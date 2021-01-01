import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NowPlaying extends StatelessWidget {
  final String MovieName;
  final String imageName;
  final String Rating;
  NowPlaying({this.MovieName, this.Rating, this.imageName });
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Container(
            height: 350.0,
            width: 270.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageName),
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(3.0),
                    ),
                  ),
                  padding: const EdgeInsets.only(
                      bottom: 3.0, top: 3.0, right: 5.0, left: 3.0),
                  child: Text(
                    MovieName,
                    style: TextStyle(
                        fontFamily: 'Amiri-Bold',
                        fontSize: 14.0,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
