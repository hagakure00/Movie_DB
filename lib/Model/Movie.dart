
import 'package:moviedb/Services/Api.dart';

import 'Person.dart';

class Movie {
  final int id;
  final String name;
  final String description;
  final String? posterPath;

  //////
  final String langue;
  final int? budget;
  final int? revenu;
  final int? time;
  ////////

  final List<String>? genres;
  final String releaseDate;
  final double? vote;

  final List<String>? videos;
  final List<Person>? casting;

  final List<String>? similar;
  final List<String>? images;

  Movie({
      required this.id,
      required this.name,
      required this.description,
      this.posterPath,
      this.genres,
      required this.releaseDate,
      this.vote,
      this.videos,
      this.casting,
      this.similar,
      this.images,
      required this.langue,
      this.budget,
      this.revenu,
      this.time
  });

  Movie copyWith({
    int? id,
    String? name,
    String? description,
    String? posterPath,

    String? langue,
    int? revenu,
    int? budget,
    int? time,

    List<String>? genres,
    String? releaseDate,
    double? vote,
    List<String>? videos,
    List<Person>? casting,
    List<String>? similar,
    List<String>? images,
}) {
    return Movie (
      id : id ?? this.id,
      name : name ?? this.name,
      description : description ?? this.description,
      posterPath : posterPath ?? this.posterPath,

      langue: langue ?? this.langue,
      budget: budget ?? this.budget,
      revenu: revenu ?? this.revenu,
      time: time ?? this.time,

      genres : genres ?? this.genres,
      releaseDate : releaseDate ?? this.releaseDate,
      vote : vote ?? this.vote,
      videos : videos ?? this.videos,
      casting : casting ?? this.casting,
      similar : similar ?? this.similar,
      images : images ?? this.images,
    );
  }

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      name: map['title'],
      description: map['overview'],
      posterPath: map['poster_path'],
      langue: map['original_language'],
      revenu: map['revenue'],
      budget: map['budget'],
      time: map['runtime'],
      releaseDate: map['release_date'],
    );
  }

  String posterUrl() {
    Api api = Api();
    return api.baseImageUrl + posterPath!;
  }

  String reformatGenres() {
    String categories = "";
    for (int i = 0; i < genres!.length; i++) {
      if (i == genres!.length -1) {
        categories = categories + genres![i];
      } else {
        categories = categories + "${genres![i]}, ";
      }
    }
    return categories;
  }

}

