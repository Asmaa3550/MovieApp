import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../Providers/FavouritesMovies.dart';
import 'package:flutter/material.dart';
import '../Utilities/StarBinner.dart';
import '../Models/CastMember.dart';
import '../Utilities/ActorListTile.dart';
import '../Utilities/getData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'MoviePlay.dart';

class movieScreen extends StatefulWidget {
  static const String ID = 'MovieScreen';
  final String posterImage;
  final String movieName;
  final String review;
  final String Rate;
  final String MovieID;
  final String genres;
  final String userId;
  movieScreen(
      {this.posterImage,
      this.movieName,
      this.Rate,
      this.review,
      this.MovieID,
      this.genres,
      this.userId});
  @override
  _movieScreenState createState() => _movieScreenState();
}

class _movieScreenState extends State<movieScreen> {
  List<CastMember> Cast = [];
  bool favIconState = false;
  GetMovies Object = new GetMovies();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final listOfFav = Provider.of<FavouriteMovies>(context);
    favIconState = listOfFav.favouriteMovies.contains(widget.MovieID);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: ListView(children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                height: 450,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.posterImage),
                      fit: BoxFit.fill),
                ),
              ),
              Positioned(
                right: 40,
                top: 420,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: IconButton(
                    color: Colors.green,
                    icon: Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    onPressed: () async {
                      GetMovies movieObject = new GetMovies();
                      String trailerId =
                          await movieObject.GetTrailerLink(widget.MovieID);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MoviePlayVideo(trailer: trailerId),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 20,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: IconButton(
                    icon: Icon(
                        favIconState ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                        size: 35),
                    onPressed: () async {
                      setState((){
                        favIconState = !favIconState;
                      });
                      if (favIconState) {
                        print('in the if statment before--------------------' + listOfFav.favouriteMovies.toString());
                        listOfFav.addMovie(widget.MovieID, widget.userId);
                        print('in the if statment after--------------------' + listOfFav.favouriteMovies.toString());
                      } else {
                        print('In else Statment----------------------' + listOfFav.favouriteMovies.toString());
                        await listOfFav.removeMovie( widget.MovieID , widget.userId);
                        print('In else Statment----------------------' + listOfFav.favouriteMovies.toString());
                      }
                    },
                  ),
                ),
              ),
              Positioned(
                left: 6,
                top: 20,
                child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          size: 30.0, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
              ),
            ],
          ),
          Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 24.0, left: 10),
                child: Text(widget.movieName,
                      style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text('Rate: ', style: TextStyle(color: Colors.white60, fontSize: 15.0)),
                    StarBinner(
                        ratingNumber: double.parse(widget.Rate) / 2,
                        starColor: Colors.amber),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.genres,
                  style: TextStyle(color: Colors.white60, fontSize: 15.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 10),
                child: Text(
                  'Over View',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w400,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  widget.review,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400 ,
                    color: Colors.white60 ,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 10),
                child: Text(
                  'Star Cast',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w400,
                    color:Colors.redAccent,
                  ),
                ),
              ),
              Container(
                height: 200,
                child: FutureBuilder(
                future: Object.GetCast(widget.MovieID),
                builder: (BuildContext context , AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                Cast = snapshot.data;
                  return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: Cast.length,
                  shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                    itemBuilder: (BuildContext context, int index)
                    {
                      return ActorListTile(
                          imageUrl: Cast[index].imageUrl,
                          name: Cast[index].actorName);
                    }
                );
                }
                else {
                  return Center(child: const Text('No items'));
                }
                }
                )
              ),
            ],
          )),
        ]),
      ),
    );
  }
}


// child: ListView.builder(
//     scrollDirection: Axis.horizontal,
//     itemBuilder: (BuildContext context, int index) {
//       GetMovies Object = new GetMovies();
//       return FutureBuilder(
//           future: Object.GetCast(widget.MovieID),
//           builder:
//               (BuildContext context, AsyncSnapshot snapshot) {
//             Cast = snapshot.data;
//             if (snapshot.connectionState ==
//                 ConnectionState.done) {
//               return ActorListTile(
//                   imageUrl: Cast[index].imageUrl,
//                   name: Cast[index].actorName);
//             } else {
//               return CircularProgressIndicator(
//                   backgroundColor: Colors.white,
//                   strokeWidth: 0);
//             }
//           });
//     }),