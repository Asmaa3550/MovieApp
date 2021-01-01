
import 'package:flutter/material.dart';
import '../Constants.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../Models/Movie.dart';
import '../Models/CastMember.dart';

import 'package:omdb_dart/omdb_dart.dart';

class GetMovies {
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
  Future GetData(String GeneralFeature) async {
    Response response = await get(
        'https://api.themoviedb.org/3/movie/$GeneralFeature?api_key=$APIKEY&language=en-US&page=1');
    if (response.statusCode == 200) {
      List<Movie> _ListOfMovies = [];
      List<String> genres = [];
      var Data = jsonDecode(response.body);

      for (int i = 0; i < Data['results'].length; i++) {
        String movieGenre = '';
        int listLength = Data['results'][i]['genre_ids'].length;
        if (Data['results'][i]['genre_ids'].length != 0) {
          for (int j = 0; j < Data['results'][i]['genre_ids'].length - 1; j++) {
            String adjGenre = genresInformation[
            '${Data['results'][i]['genre_ids'][j].toString()}'];
            movieGenre = movieGenre + adjGenre + ',';
          }
          movieGenre = movieGenre +
              genresInformation[
              '${Data['results'][i]['genre_ids'][listLength - 1].toString()}'];
        }

        _ListOfMovies.add(Movie(
            Name: Data['results'][i]['title'],
            MovieID: Data['results'][i]['id'].toString(),
            ImageName: Data['results'][i]['poster_path'],
            votingAvg: Data['results'][i]['vote_average'].toString(),
            Review: Data['results'][i]['overview'],
            genre_id: movieGenre));
      }

      return _ListOfMovies;
    } else {
      return (response.statusCode);
    }
  }

  String GetImage(String ImageSize, String ImageName) {
    return ('https://image.tmdb.org/t/p/$ImageSize$ImageName');
  }

  Future GetTrailerLink(String movieId) async {
    Response response = await get(
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$APIKEY&language=en-US');
    var JsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (int i = 0; i < JsonData['results'].length; i++) {
        if (JsonData['results'][i]['type'].toString() == 'Trailer') {
          print('trailre id = ' + JsonData['results'][i]['key'].toString());
          return JsonData['results'][i]['key'].toString();
        }
      }
    } else {print (response.statusCode);}
  }

  Future GetCast(String movieId) async {
    Response response = await get(
        'https://api.themoviedb.org/3/movie/$movieId?api_key=$APIKEY&append_to_response=credits');
    var JsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<CastMember> cast = [];
      for (int i = 0; i < JsonData['credits']['cast'].length; i++) {
        cast.add(CastMember(
            actorName:
            JsonData['credits']['cast'][i]['original_name'].toString(),
            imageUrl: GetImage(
                'w400', JsonData['credits']['cast'][i]['profile_path'])));
      }
      return cast;
    } else {
      return (response.statusCode);
    }
  }

  Future  FindMovie(String Query) async {
    Response response = await get(
        'https://api.themoviedb.org/3/search/movie?api_key=$APIKEY&language=en-US&query=$Query&page=1&include_adult=false');
    if (response.statusCode == 200) {
      var Data = jsonDecode(response.body);
      List<Movie> listOfMovie = [];

      if (Data['results'].length == 0) {
        return null;
      }
      else {
        for (int i = 0; i < Data['results'].length; i++) {
          String movieGenre = '';
          int listLength = Data['results'][i]['genre_ids'].length;
          if (Data['results'][i]['genre_ids'].length != 0) {
            for (int j = 0;
            j < Data['results'][i]['genre_ids'].length - 1;
            j++) {
              String adjGenre = genresInformation[
              '${Data['results'][i]['genre_ids'][j].toString()}'];
              movieGenre = movieGenre + adjGenre + ',';
            }
            movieGenre = movieGenre +
                genresInformation[
                '${Data['results'][i]['genre_ids'][listLength - 1].toString()}'];
          }
          listOfMovie.add(Movie(
              Name: Data['results'][i]['original_title'],
              MovieID: Data['results'][i]['id'].toString(),
              ImageName: Data['results'][i]['poster_path'],
              votingAvg: Data['results'][i]['vote_average'].toString(),
              Review: Data['results'][i]['overview'],
              genre_id: movieGenre));
        }
        print(listOfMovie.length);
        return listOfMovie;
      }
    }
    else {
      return response.statusCode;
    }
  }

  Future GetFavMovies (List <String> moviesId) async {
    List<Movie> _ListOfMovies = [];

    for (int i =0 ; i<moviesId.length ; i++)
    {
      Response response = await get('https://api.themoviedb.org/3/movie/${moviesId[i]}?api_key=$APIKEY&language=en-US');
      if (response.statusCode == 200) {
        var Data = jsonDecode(response.body);
        String movieGenre = '';
        List listOfGenres= Data['genres'];

        for (int k =0 ; k<listOfGenres.length - 1 ; k++)
          {
            movieGenre = movieGenre + listOfGenres[k]['name'].toString() + ',';
          }
        movieGenre = movieGenre + listOfGenres[listOfGenres.length - 1]['name'].toString();

        _ListOfMovies.add(Movie(
            Name: Data['original_title'],
            MovieID: Data['id'].toString(),
            ImageName: Data['poster_path'],
            votingAvg: Data['vote_average'].toString(),
            Review: Data['overview'],
            genre_id: movieGenre));

      }
    }
    return _ListOfMovies;
  }
}
//get the details (geners)
//https://api.themoviedb.org/3/movie/539885?api_key=166bca665fec1e322ba66d941f9fd0a8&language=en-US
// get video using append_to_response...
// https://api.themoviedb.org/3/movie/297762?api_key=166bca665fec1e322ba66d941f9fd0a8&append_to_response=videos
//get video
//https://api.themoviedb.org/3/movie/539885/videos?api_key=166bca665fec1e322ba66d941f9fd0a8&language=en-US
// search
//https://api.themoviedb.org/3/search/movie?api_key=166bca665fec1e322ba66d941f9fd0a8&language=en-US&query=ev&page=1&include_adult=false

