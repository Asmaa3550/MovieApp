import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Providers/FavouritesMovies.dart';
import 'Providers/uiProvider.dart';
import 'Screens/Home_Screen.dart';
import 'Screens/Register_Screen.dart';
import 'Screens/Signin_Screen.dart';
import 'Screens/Movie_Screen.dart';
import 'Screens/MoviePlay.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Screens/Search_Screen.dart';
import 'Screens/favourite_Screen.dart';
import 'Screens/TestScreen.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(moviesApp());
}

class moviesApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MultiProvider(
            providers: [
                ChangeNotifierProvider(
                    create: (_) => UI(),
                ),
                ChangeNotifierProvider(
                create: (context) => FavouriteMovies() ,
                ),
            ],
            child: MaterialApp(
                home:SigninScreen(),
                    routes: {
                        SigninScreen.ID: (context) => SigninScreen(),
                        RegisterScreen.ID: (context) => RegisterScreen(),
                        homePage.ID: (context) => homePage(),
                        movieScreen.ID: (context) => movieScreen(),
                        MoviePlayVideo.ID: (context) => MoviePlayVideo(),
                        SearchScreen.ID: (context) => SearchScreen(),
                        FavouriteScreen.ID : (context) => FavouriteScreen(),

                },
            ),
        );
    }
}
