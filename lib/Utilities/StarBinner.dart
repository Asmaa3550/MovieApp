import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarBinner extends StatelessWidget {
  final double ratingNumber;
  final Color starColor;
  StarBinner({this.ratingNumber, this.starColor});
  @override
  Widget build(BuildContext context) {
    return RatingBar(
      glowColor: starColor,
      itemSize: 20,
      initialRating: ratingNumber,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: starColor,
        size: 5,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
