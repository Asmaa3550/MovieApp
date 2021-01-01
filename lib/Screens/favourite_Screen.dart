import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/FavouritesMovies.dart';
import '../Utilities/getData.dart';
import '../Models/Movie.dart';
import 'Movie_Screen.dart';
import '../Utilities/FilmPoster.dart';

class FavouriteScreen extends StatefulWidget {
  static const ID = 'FavouriteScreen';

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> with SingleTickerProviderStateMixin {
  String movieName;
  String imageName;
  String MovieID;
  String Review;
  String votingAvg;
  String genres;
  Animation animation ;
  AnimationController animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 2) , vsync: this);
    animation = Tween(begin: -1.0 , end: 0).animate(CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: animationController
    ));
  }
  @override
  Widget build(BuildContext context) {
    List listOfFav =  Provider.of<FavouriteMovies>(context).favouriteMovies;
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();
    return AnimatedBuilder (
      animation: animationController,
      builder: (BuildContext context ,Widget child){
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
                 'Favourites',
                  style: TextStyle(color: Colors.redAccent, fontSize: 25.0),
                ),
                 elevation: 0,
            backgroundColor: Colors.black12,
          ),
        ),
      ),
           body: Container(
                width: 500.0,
                padding: EdgeInsets.only(top: 20.0),
                height: double.infinity,
                child: listOfFav.length > 0
                    ? ListView.separated(
                        itemCount: listOfFav.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          GetMovies results = new GetMovies();
                          return FutureBuilder(
                              future: results.GetFavMovies(listOfFav),
                              builder:
                                  (BuildContext context, AsyncSnapshot snapshot) {
                                List<Movie> listOfmovies = [];
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  listOfmovies = snapshot.data;
                                  this.movieName = listOfmovies[index].Name;
                                  this.imageName = listOfmovies[index].ImageName;
                                  this.votingAvg = listOfmovies[index].votingAvg;
                                  this.Review = listOfmovies[index].Review;
                                  this.MovieID = listOfmovies[index].MovieID;
                                  this.genres = listOfmovies[index].genre_id;
                                  return GestureDetector(
                                    onTap: () {
                                      this.movieName = listOfmovies[index].Name;
                                      this.imageName =
                                          listOfmovies[index].ImageName;
                                      this.votingAvg =
                                          listOfmovies[index].votingAvg;
                                      this.Review = listOfmovies[index].Review;
                                      this.MovieID = listOfmovies[index].MovieID;
                                      this.genres = listOfmovies[index].genre_id;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => movieScreen(
                                              posterImage: results.GetImage(
                                                  'w400', imageName),
                                              MovieID: MovieID,
                                              movieName: movieName,
                                              Rate: votingAvg,
                                              review: Review,
                                              genres: genres),
                                        ),
                                      );
                                    },
                                    child: Transform(
                                      transform:Matrix4.translationValues(animation.value * width, 0.0, 0.0),
                                      child: FilmPoster(
                                          MovieName: this.movieName,
                                          imageName:
                                              results.GetImage('w400', imageName),
                                          Rating: this.votingAvg),
                                    ),
                                  );
                                } else {
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
                              });
                        },
                  separatorBuilder: (BuildContext context, int index) => const Divider( color: Colors.white38,endIndent: 30,indent: 30,height: 20,),
                      )
                    : Center(child: const Text('No items' , style: TextStyle(color:Colors.white),)),
              ),
        )
    );
      },
    );
  }
}
