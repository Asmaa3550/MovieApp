import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Signin_Screen.dart';
import 'package:provider/provider.dart';
import '../Utilities/getData.dart';
import '../Models/Movie.dart';
import '../Utilities/NowPlaying.dart';
import '../DataInformation.dart';
import '../Utilities/ListOfMovies.dart';
import '../Utilities/TitleOfListMovies.dart';
import '../Screens/Movie_Screen.dart';
import '../Screens/favourite_Screen.dart';
import 'Search_Screen.dart';
import '../Utilities/DrawerList.dart';

class homePage extends StatefulWidget {
  static const ID = 'HomeScreen';
  final User LoggedUserName;
  homePage({this.LoggedUserName});
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  final _auth = FirebaseAuth.instance;
  final upComingKey = new GlobalKey();
  final nowPlayingKey = new GlobalKey();
  final popularKey = new GlobalKey();
  final topRatingKey = new GlobalKey();

  GetMovies MovieObject = new GetMovies();
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        primary: true ,
        backgroundColor: Colors.black87,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Builder(
            builder: (context) => AppBar(
              backgroundColor: Colors.black54,
              title: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text('Home',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 25.0,
                        fontFamily: 'MajorMonoDisplay',
                        fontWeight: FontWeight.w600)),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                child: IconButton(
                  icon: Icon(
                    Icons.dehaze,
                    size: 25.0,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              shadowColor: Colors.transparent,
              actions: <Widget>[
                Container(
                    height: 60,
                    width: 60,
                    margin: EdgeInsets.only(top: 15.0, right: 15.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black12,
                    ),
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.search,
                          size: 33,
                          color:Colors.redAccent,
                        ),
                        tooltip: 'Add new entry',
                        onPressed: () {
                          Navigator.pushNamed(context, SearchScreen.ID);
                        },
                      ),
                    )),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.black87,
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome' , style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            color: Colors.red),),
                        Text(
                          widget.LoggedUserName.email,
                           style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w400,
                              color: Colors.white38),
                        ),
                      ],
                    )),
                drawerListView(title: 'Home', iconName: Icon(Icons.home , color: Colors.red,) , Progress: (){
                  Navigator.pushNamed(context, homePage.ID);
                }),
                drawerListView(
                    title: 'Favorites', iconName: Icon(Icons.favorite , color: Colors.white38,) , Progress: (){
                      Navigator.pushNamed(context, FavouriteScreen.ID);
                }),
                drawerListView(
                  title: 'Sign Out',
                  iconName: Icon(Icons.exit_to_app ,color: Colors.white38),
                  Progress: () {
                    _auth.signOut();
                    Navigator.pushNamed(context, SigninScreen.ID);
                  },
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   height: 40,
              //   child: ListView(
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     children: [
              //       GestureDetector(
              //         onTap: ()=> Scrollable.ensureVisible(upComingKey.currentContext),
              //         child: CategoryNamesList[0],
              //       ),
              //     ],
              //   ),
              // ),
              TextTitle(title: 'Now Playing'),
              Container(
                height: 350,
                child: FutureBuilder(
                    future: MovieObject.GetData(NowPlayingFeature),
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
                                            userId: widget.LoggedUserName.uid),
                                      ),
                                    );
                                  },
                                  child: NowPlaying(
                                  MovieName: NowPlayingList[index].Name,
                                  imageName: MovieObject.GetImage(
                                      'w400', NowPlayingList[index].ImageName),
                                  Rating: NowPlayingList[index].votingAvg),
                                ),
                              );
                            });
                      }
                      else{
                        return Container(padding: EdgeInsets.only(left: 30),
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
              ),
              
              TextTitle(title: 'Top Rated'),
              ListOfMovies(
                  movieFeature: TopRatedFeature, userId: widget.LoggedUserName.uid),
              TextTitle(title: 'Popular'),
              ListOfMovies(
                  movieFeature: PopularFeature, userId: widget.LoggedUserName.uid),
              TextTitle(title: 'Up Coming'),
              ListOfMovies(
                  movieFeature: UpComingFeature, userId: widget.LoggedUserName.uid),

            ],
          ),
        ),
      );
  }
}

