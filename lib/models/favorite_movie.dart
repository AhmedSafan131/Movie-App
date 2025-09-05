class FavoriteMovie {
  String? movieId;
  String? name;
  double? rating;
  String? imageURL;
  String? year;

  FavoriteMovie(
      {this.movieId, this.name, this.rating, this.imageURL, this.year});

  factory FavoriteMovie.fromJson(Map<String, dynamic> json) {
    return FavoriteMovie(
      movieId: json['movieId'],
      name: json['name'],
      rating: (json['rating'] as num?)?.toDouble(),
      imageURL: json['imageURL'],
      year: json['year'],
    );
  }
}
