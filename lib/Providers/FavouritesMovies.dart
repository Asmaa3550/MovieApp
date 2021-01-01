import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavouriteMovies with ChangeNotifier
{
  List<String> favouriteMovies = new List<String> ();

  void loadData (String userId) async {
    DocumentReference users = FirebaseFirestore.instance.collection('UserFav').doc(userId);

    DocumentSnapshot Data = await users.get();
    if (Data.exists)
      {
        var map = Data.data();
        List listOfIds = map['Favourite'];
        for (int i =0 ; i<listOfIds.length ; i++)
        {
          favouriteMovies.add('${listOfIds[i]}');
        }
      }
    else
      {
         favouriteMovies = [];
      }
    notifyListeners();
  }

  void removeMovie (String movieId , String userId) async {
    favouriteMovies.remove(movieId);
    DocumentReference users = FirebaseFirestore.instance.collection('UserFav').doc(userId);
    await users.update({'Favourite' : favouriteMovies});
    notifyListeners();
  }

  Future addMovie (String movieId , String userId) async{
    favouriteMovies.add(movieId);
    await AddMovieIdToFireBase(movieId , userId);
    notifyListeners();
  }

}

Future AddMovieIdToFireBase(String movieId , String userId) async {

  DocumentReference users = FirebaseFirestore.instance.collection('UserFav').doc(userId);
  DocumentSnapshot doc = await users.get();

  if (doc.exists) {
    users.update({
      'Favourite': FieldValue.arrayUnion([movieId])
    });
  }

  else {
    var _firestore = FirebaseFirestore.instance.collection('UserFav').doc(userId).set({
      'Favourite': FieldValue.arrayUnion([movieId])
    });
  }
}
