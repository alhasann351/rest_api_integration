class GetApiModel {
  List<Movies>? movies;
  int? page;

  GetApiModel({this.movies, this.page});

  GetApiModel.fromJson(Map<String, dynamic> json) {
    if (json['movies'] != null) {
      movies = <Movies>[];
      json['movies'].forEach((v) {
        movies!.add(new Movies.fromJson(v));
      });
    }
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.movies != null) {
      data['movies'] = this.movies!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    return data;
  }
}

class Movies {
  int? iId;
  String? backdropPath;
  List<String>? genres;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? releaseDate;
  String? title;
  String? contentType;

  Movies(
      {this.iId,
      this.backdropPath,
      this.genres,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.contentType});

  Movies.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    backdropPath = json['backdrop_path'];
    genres = json['genres'].cast<String>();
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    contentType = json['contentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['backdrop_path'] = this.backdropPath;
    data['genres'] = this.genres;
    data['original_title'] = this.originalTitle;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    data['release_date'] = this.releaseDate;
    data['title'] = this.title;
    data['contentType'] = this.contentType;
    return data;
  }
}
