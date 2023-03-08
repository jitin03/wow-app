import 'package:flutter/material.dart';


class ProviderButton extends StatelessWidget {

  String buttonName;
  String formData;
  ProviderButton(this.buttonName, this.formData);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0Xff5F60B9),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
          // Background color
        ),
        onPressed: () {

          print(formData);

        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(buttonName),
        ));
  }
}