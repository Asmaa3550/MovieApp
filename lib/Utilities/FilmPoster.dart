import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../Utilities/StarBinner.dart';

class FilmPoster extends StatelessWidget {
  final String MovieName;
  final String imageName;
  final String Rating;
  FilmPoster({this.MovieName, this.imageName, this.Rating});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 13.0),
      width: 180.0,
      child: Wrap(
        children: <Widget>[
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(),
                width: 180.0,
                height: 200.0,
                imageUrl: imageName,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(
                  MovieName.length < 24
                      ? MovieName
                      : (MovieName.substring(0, 20) + '...'),
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Amiri-Bold',
                    color: Colors.white
                  ),
                ),
              ),
              Positioned(
                  top: 20.0,
                  left: 5.0,
                  child: StarBinner(
                      ratingNumber: (double.parse(Rating) / 2),
                      starColor: Colors.amberAccent)),
            ],
          ),
        ],
      ),
    );
  }
}
