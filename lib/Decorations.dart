import 'package:flutter/material.dart';

InputDecoration KInputDecoration(String hint) {
  return InputDecoration(
    focusColor: Colors.white38,
    labelText: hint,
    labelStyle: TextStyle(color: Colors.white38 , fontSize: 15),
    focusedBorder:
    OutlineInputBorder(borderSide: new BorderSide( color: Colors.white38 , style: BorderStyle.solid) , gapPadding: 40 , borderRadius: BorderRadius.circular(6)),
    hintStyle: TextStyle(color: Colors.grey.shade300),
    errorBorder: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.red) , gapPadding: 40 , borderRadius: BorderRadius.circular(6)),
    enabledBorder:  new OutlineInputBorder(borderSide: new BorderSide( color: Colors.white38 , style: BorderStyle.solid),  gapPadding: 40, borderRadius: BorderRadius.circular(6)),
    border:  new OutlineInputBorder(borderSide: new BorderSide( color: Colors.white38 , style: BorderStyle.solid) , gapPadding: 40 ,  borderRadius: BorderRadius.circular(6)),

  );
}
