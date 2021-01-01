import 'package:cloud_firestore/cloud_firestore.dart';

class FavouriteMoviesId {
  void AddMovieId(String userId, String movieId) async {

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

  void DeleteMovieId(String userId, String movieId) async{
    DocumentReference users =
    FirebaseFirestore.instance.collection('UserFav').doc(userId);

    DocumentSnapshot Data = await users.get();
    var map = Data.data();
    List listOfIds = map['Favourite'];
    listOfIds.remove(movieId);
    // List<String> newList = [];
    // for(int i=0 ; i<listOfIds.length ; i++)
    // {
    //   if(listOfIds[i] != 'test2')
    //   {
    //     newList.add(listOfIds[i].toString());
    //   }
    // }
    users.update({'Favourite' : listOfIds});
  }
}
