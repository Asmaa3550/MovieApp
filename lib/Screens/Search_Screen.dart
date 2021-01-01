import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../Utilities/getData.dart';
import '../Models/Movie.dart';
import '../Utilities/FilmPoster.dart';
import 'Home_Screen.dart';
import 'Movie_Screen.dart';

class SearchScreen extends StatefulWidget {
  static const String ID = 'SearchScreen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String pattern = '';
  String PasicString = '';
  String movieName;
  String imageName;
  String MovieID;
  String Review;
  String votingAvg;
  String genres;
  GetMovies results = new GetMovies();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black54,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Builder(
              builder: (context) => AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.redAccent),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  'Search',
                  style: TextStyle(color: Colors.redAccent, fontSize: 25.0),
                ),
                elevation: 0,
                backgroundColor: Colors.black54,
              ),
            ),
          ),
          body: Container(
              color: Colors.black12,
              child: (Column(
                children: <Widget>[
                  Container(
                    height: 80.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    bottomLeft: Radius.circular(4.0)),
                                color: Colors.white12),
                            margin: const EdgeInsets.only(left: 8.0),
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Search by name of Movie ',
                                labelStyle: TextStyle(color: Colors.grey[600]),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                    gapPadding: 30,
                                    borderSide: BorderSide.none),
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade300),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  PasicString = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.only(right: 8.0),
                            child: FlatButton(
                              color: Colors.white60,
                              onPressed: () {
                                setState(() {
                                  pattern = PasicString;
                                });
                              },
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 500.0,
                      padding: EdgeInsets.only(bottom: 10.0),
                      height: double.infinity,
                      child: pattern != ''
                         ? FutureBuilder(
                          future: results.FindMovie(this.pattern),
                          builder: (BuildContext context , AsyncSnapshot snapshot) {
                            List<Movie> listOfmovies = [];
                            if (snapshot.connectionState == ConnectionState.done) {
                              listOfmovies = snapshot.data;
                              print('length of list from screen ' + snapshot.data.length.toString());
                              return ListView.separated(
                                  itemCount: listOfmovies.length,
                                  shrinkWrap: true,
                                  separatorBuilder: (BuildContext context, int index) => const Divider( color: Colors.white38,endIndent: 30,indent: 30,height: 20,),
                                  itemBuilder: (BuildContext context, int index)
                                  {
                                    this.movieName =
                                        snapshot.data[index].Name;
                                    this.imageName =
                                        snapshot.data[index].ImageName;
                                    this.votingAvg =
                                        snapshot.data[index].votingAvg;
                                    this.Review =
                                        snapshot.data[index].Review;
                                    this.MovieID =
                                        snapshot.data[index].MovieID;
                                    this.genres =
                                        snapshot.data[index].genre_id;
                                    return Container(
                                      // height:300 ,
                                      child: GestureDetector(
                                      onTap: () {
                                        this.movieName =
                                            snapshot.data[index].Name;
                                        this.imageName =
                                            snapshot.data[index].ImageName;
                                        this.votingAvg =
                                            snapshot.data[index].votingAvg;
                                        this.Review =
                                            snapshot.data[index].Review;
                                        this.MovieID =
                                            snapshot.data[index].MovieID;
                                        this.genres =
                                            snapshot.data[index].genre_id;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                movieScreen(
                                                    posterImage:
                                                        results.GetImage(
                                                            'w400',
                                                            imageName),
                                                    movieName: movieName,
                                                    Rate: votingAvg,
                                                    review: Review,
                                                    MovieID: MovieID,
                                                    genres: genres),
                                          ),
                                        );
                                      },
                                      child: FilmPoster(
                                          MovieName: this.movieName,
                                          imageName: results.GetImage(
                                              'w400', imageName),
                                          Rating: this.votingAvg),
                                      ),
                                    );
                                  });
                            }
                            else{
                              return Container(
                                width:50,
                                height: 50,
                                child: WavyAnimatedTextKit(
                                  textStyle: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white38
                                  ),
                                  text: [
                                    "Loading",
                                  ],
                                  isRepeatingAnimation: true,
                                ),
                              );
                            }
                          }
                            )
                          : Center(child: const Text('No items' , style: TextStyle(color:Colors.white38),)),
                    ),
                  ),
                ],
              )))),
    );
  }
}
