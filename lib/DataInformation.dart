import 'package:flutter/material.dart';

const String NowPlayingFeature = 'now_playing';
const String UpComingFeature = 'upcoming';
const String TopRatedFeature = 'top_rated';
const String PopularFeature = 'popular';

List<CategoryButton> CategoryNamesList = [
  CategoryButton(buttonText: 'All', buttonColor: Colors.red[200]),
  CategoryButton(buttonText: 'Now Playing', buttonColor: Colors.grey),
  CategoryButton(buttonText: 'Top Rated', buttonColor: Colors.grey),
  CategoryButton(buttonText: 'Popular', buttonColor: Colors.grey),
  CategoryButton(buttonText: 'Upcoming', buttonColor: Colors.grey),
];

var genresInformation = {
  '28': 'Action',
  '12': 'Adventure',
  '16': 'Animation',
  '35': 'Comedy',
  '80': 'Crime',
  '99': 'Documentary',
  '18': 'Drama',
  '10751': 'Family',
  '14': 'Fantasy',
  '36': 'History',
  '27': 'Horror',
  '10402': 'Music',
  '9648': 'Mystery',
  '10749': 'Romance',
  '878': 'Science Fiction',
  '10770': 'TV Movie',
  '53': 'Thriller',
  '10752': 'War',
  '37': 'Western'
};

class CategoryButton extends StatelessWidget {
  final Color buttonColor;
  final String buttonText;
  final Function  onPressedFunction ;
  GlobalKey key = GlobalKey();
  CategoryButton({this.buttonColor, this.buttonText, this.key , this.onPressedFunction});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: OutlineButton(
        onPressed: () {
          this.onPressedFunction();
        },
        child: Text(buttonText, style: TextStyle(color: buttonColor)),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        borderSide: BorderSide(color: buttonColor),
      ),
    );
  }
}
