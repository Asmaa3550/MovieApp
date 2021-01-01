import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  final String title;
  TextTitle({this.title});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            left: 0,
            top: 15.0,
            child: Container(
              width: 8.0,
              height: 27.0,
              color: Colors.redAccent,
            )),
        Padding(
          padding: const EdgeInsets.only(left: 13.0, top: 15.0, bottom: 15.0),
          child: Text(title,
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 23.0,
                fontWeight: FontWeight.w400,
                // fontFamily: 'MajorMonoDisplay',
              ),
              textAlign: TextAlign.start),
        )
      ],
    );
  }
}
