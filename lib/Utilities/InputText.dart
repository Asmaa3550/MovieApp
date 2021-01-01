import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Decorations.dart';

class InputTextField extends StatelessWidget {
  final String title;
  final Function OnChange;
  final Function Validator;
  final bool passFormat ;
  InputTextField({this.title, this.OnChange, this.Validator , this.passFormat = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            elevation: 10,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: TextFormField(
              obscureText: passFormat,
              validator: (value) {
                Validator(value);},
              decoration: KInputDecoration(title),
              onChanged: (value) {
                OnChange(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
