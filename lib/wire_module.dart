import 'package:flutter/material.dart';

class WireModule extends StatefulWidget {
  @override
  _WireModuleState createState() => _WireModuleState();
}

class _WireModuleState extends State<WireModule> {
  int numWires = 4;
  List<String> wires = List.filled(4, '');
  String serialNumber = '';
  String instructions = '';

  void handleSubmit() {
    String tempInstructions = '';
    int numRed = wires.where((color) => color == 'rouge').length;
    int lastDigitSerial = int.tryParse(serialNumber.substring(serialNumber.length - 1)) ?? 0;
    String lastColor = wires.last;

    if (numWires == 3) {
      if (!wires.contains('rouge')) {
        tempInstructions = 'Couper le deuxième fil.';
      } else if (wires.where((color) => color == 'bleu').length > 1) {
        tempInstructions = 'Couper le dernier fil bleu.';
      } else {
        tempInstructions = 'Couper le dernier fil.';
      }
    } else if (numWires == 4) {
      if (numRed > 1 && lastDigitSerial % 2 == 1) {
        tempInstructions = 'Couper le dernier fil rouge.';
      } else if (lastColor == 'jaune' && !wires.contains('rouge')) {
        tempInstructions = 'Couper le premier fil.';
      } else if (wires.contains('bleu')) {
        tempInstructions = 'Couper le premier fil.';
      } else if (wires.contains('jaune')) {
        tempInstructions = 'Couper le dernier fil.';
      } else {
        tempInstructions = 'Couper le deuxième fil.';
      }
    } else if (numWires == 5) {
      if (lastColor == 'noir' && lastDigitSerial % 2 == 1) {
        tempInstructions = 'Couper le quatrième fil.';
      } else if (!wires.contains('noir')) {
        tempInstructions = 'Couper le deuxième fil.';
      } else {
        tempInstructions = 'Couper le premier fil.';
      }
    } else if (numWires == 6) {
      if (!wires.contains('jaune') && lastDigitSerial % 2 == 1) {
        tempInstructions = 'Couper le troisième fil.';
      } else if (numRed == 0) {
        tempInstructions = 'Couper le dernier fil.';
      } else {
        tempInstructions = 'Couper le quatrième fil.';
      }
    }

    setState(() {
      instructions = tempInstructions;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text("Nombre de fils:"),
            DropdownButton<int>(
              value: numWires,
              onChanged: (int? newValue) {
                if (newValue != null) {
                  setState(() {
                    numWires = newValue;
                    wires = List.filled(newValue, '');
                  });
                }
              },
              items: [3, 4, 5, 6].map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
            ...List.generate(numWires, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Fil ${index + 1}:"),
                  DropdownButton<String>(
                    value: wires[index],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          wires[index] = newValue;
                        });
                      }
                    },
                    items: ['', 'bleu', 'rouge', 'noir', 'jaune', 'blanc']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              );
            }),
            TextField(
              decoration: InputDecoration(labelText: "Numéro de série:"),
              onChanged: (value) {
                setState(() {
                  serialNumber = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: handleSubmit,
              child: Text("Vérifier"),
            ),
            Text("Instructions:"),
            Text(instructions),
          ],
        ),
      ),
    );
  }
}
