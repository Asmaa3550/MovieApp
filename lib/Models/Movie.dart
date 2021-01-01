class Movie {
  final String Name;
  final String ImageName;
  final String MovieID;
  final List<String> Cast;
  final String Review;
  final String votingAvg;
  final String genre_id;

  Movie(
      {this.Name,
      this.ImageName,
      this.MovieID,
      this.Cast,
      this.Review,
      this.votingAvg,
      this.genre_id});
}
