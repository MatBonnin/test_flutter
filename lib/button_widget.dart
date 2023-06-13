import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  String buttonColor = '';
  String buttonText = '';
  int numBatteries = 0;
  String indicator = '';
  String instructions = '';
  String stripColor = '';
  bool show = false;

  String releaseAction() {
    if (stripColor == 'bleu') {
      return '4';
    } else if (stripColor == 'jaune') {
      return '5';
    } else {
      return '1';
    }
  }

  void handleSubmit() {
    String tempInstructions = '';

    if ((numBatteries > 1 && buttonText == 'Exploser') ||
        (numBatteries > 2 && indicator == 'FRK') ||
        (buttonColor == 'rouge' && buttonText == 'Maintenir')) {
      tempInstructions = 'Appuyer et immédiatement relâcher le bouton.';
    } else {
      if (!show) {
        setState(() {
          show = true;
        });
      } else {
        tempInstructions = 'Maintenir le bouton appuyé et relâcher lorsque le compte à rebours affiche un ' + releaseAction();
      }
    }

    setState(() {
      instructions = tempInstructions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
     child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        Text('À propos du Bouton', style: TextStyle(fontSize: 20)),
        Container(
        width: double.infinity,
        child: DropdownButton<String>(
          isExpanded: true,
          value: buttonColor,
          hint: Text('Sélectionner une couleur'),
          onChanged: (String? newValue) {
            setState(() {
              buttonColor = newValue!;
            });
          },
          items: <String>['', 'bleu', 'blanc', 'jaune', 'rouge']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        ),
        DropdownButton<String>(
          value: buttonText,
          hint: Text('Sélectionner un texte'),
          onChanged: (String? newValue) {
            setState(() {
              buttonText = newValue!;
            });
          },
          items: <String>['', 'Annuler', 'Exploser', 'Maintenir']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        if (show)
          Column(

            children: [
               SizedBox(
                 width: 200,
              child: TextField(

                keyboardType: TextInputType.number,
                onChanged: (text) {
                  setState(() {
                    numBatteries = int.tryParse(text) ?? 0;
                  });
                },
                decoration: InputDecoration(labelText: 'Nombre de piles'),
              ),
               ),
              DropdownButton<String>(
                value: indicator,
                hint: Text('Sélectionner un indicateur'),
                onChanged: (String? newValue) {
                  setState(() {
                    indicator = newValue!;
                  });
                },
                items: <String>['', 'AUTRE', 'FRK']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ElevatedButton(
          onPressed: handleSubmit,
          child: Text('Vérifier'),
        ),
        Text('Instructions: $instructions'),
      ]
    ),

    );
  }
}
