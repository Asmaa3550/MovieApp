import 'package:flutter/material.dart';
import '../Utilities/getData.dart';
import '../Models/Movie.dart';
import '../Utilities/FilmPoster.dart';
import '../Screens/Movie_Screen.dart';
import '../Providers/FavouritesMovies.dart';
import 'package:provider/provider.dart';

class ListOfMovies extends StatelessWidget {
  final String movieFeature;
  String movieName;
  String imageName;
  String MovieID;
  String Review;
  String votingAvg;
  String genres;
  final String userId;
  List<Movie> listOfmovies = [];
  GetMovies MovieObject = new GetMovies();

  ListOfMovies({this.movieFeature, this.userId});

  @override
  Widget build(BuildContext context) {
    List<String> favouriteIds = Provider.of<FavouriteMovies>(context).favouriteMovies;
    return Container(
      height: 250.0,
        child: FutureBuilder(
            future: MovieObject.GetData(movieFeature),
            builder: (BuildContext context , AsyncSnapshot snapshot) {
              List<Movie> listOfmovies = [];
              if (snapshot.connectionState == ConnectionState.done) {
                listOfmovies = snapshot.data;
                return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: listOfmovies.length,
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                    itemBuilder: (BuildContext context, int index)
                    {
                      List<Movie> NowPlayingList = [];
                      NowPlayingList = snapshot.data;
                      String movieName = NowPlayingList[index].Name;
                      String imageName = NowPlayingList[index].ImageName;
                      String MovieID = NowPlayingList[index].MovieID;
                      String Review = NowPlayingList[index].Review;
                      String votingAvg = NowPlayingList[index].votingAvg;
                      String genres = NowPlayingList[index].genre_id;

                      return Container(
                        // height:300 ,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => movieScreen(
                                    posterImage: MovieObject.GetImage(
                                        'w400', imageName),
                                    movieName: movieName,
                                    Rate: votingAvg,
                                    review: Review,
                                    MovieID: MovieID,
                                    genres: genres,
                                    userId: userId),
                              ),
                            );
                          },
                          child: FilmPoster(
                              MovieName: NowPlayingList[index].Name,
                              imageName: MovieObject.GetImage(
                                  'w400', NowPlayingList[index].ImageName),
                              Rating: NowPlayingList[index].votingAvg),
                        ),
                      );
                    });
              }
              else{
                return Center(child: const Text('No items'));
                // CircularProgressIndicator(
                //     backgroundColor: Colors.white,
                //     strokeWidth: 0,
                //   );
              }
            }
        )
    );
  }
}


// child: ListView.builder(
//   scrollDirection: Axis.horizontal,
//   itemBuilder: (BuildContext context, int index) {
//     return FutureBuilder(
//         future: MovieObject.GetData(movieFeature),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             listOfmovies = snapshot.data;
//             this.movieName = listOfmovies[index].Name;
//             this.imageName = listOfmovies[index].ImageName;
//             this.votingAvg = listOfmovies[index].votingAvg;
//             this.Review = listOfmovies[index].Review;
//             this.MovieID = listOfmovies[index].MovieID;
//             this.genres = listOfmovies[index].genre_id;
//             return GestureDetector(
//               onTap: () {
//                 this.movieName = listOfmovies[index].Name;
//                 this.imageName = listOfmovies[index].ImageName;
//                 this.votingAvg = listOfmovies[index].votingAvg;
//                 this.Review = listOfmovies[index].Review;
//                 this.MovieID = listOfmovies[index].MovieID;
//                 this.genres = listOfmovies[index].genre_id;
//
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => movieScreen(
//                         posterImage:
//                             MovieObject.GetImage('w400', this.imageName),
//                         movieName: this.movieName,
//                         Rate: this.votingAvg,
//                         review: this.Review,
//                         MovieID: this.MovieID,
//                         genres: this.genres,
//                         userId: this.userId,
//                         ),
//                   ),
//                 );
//               },
//               child: FilmPoster(
//                   MovieName: this.movieName,
//                   imageName: MovieObject.GetImage('w400', imageName),
//                   Rating: this.votingAvg),
//             );
//           } else {
//             return CircularProgressIndicator(
//               backgroundColor: Colors.white,
//               strokeWidth: 0,
//             );
//           }
//         });
//   },
// ),