class Movie {
  bool adult;
  String title;

  Movie(
      {this.adult,
        this.title,
      });

  Movie.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    title = json['title'];
  }
}

