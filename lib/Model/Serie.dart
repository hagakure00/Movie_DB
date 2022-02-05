

import 'package:moviedb/Services/Api.dart';

import 'Person.dart';

class Serie {

  final int id;
  final String name;
  final String description;
  final String? posterPath;
  final List<String>? genres;

  final int? seasons;
  final double? vote;
  final String? langue;
  final String? statut;
  final String? firstTime;
  final String? lastTime;
  final bool? isProduct;

  final List<Person>? casting;
  final List<String>? videos;
  final List<String>? images;

  Serie({
    required this.id,
    required this.name,
    required this.description,
    this.posterPath,
    this.genres,

    this.seasons,
    this.vote,
    this.langue,
    this.statut,
    this.firstTime,
    this.lastTime,
    this.isProduct,
    this.casting,
    this.images,
    this.videos


});

  Serie copyWith({
    int? id,
    String? name,
    String? description,
    String? posterPath,
    List<String>? genres,

    int? seasons,
    double? vote,
    String? langue,
    String? statut,
    String? firstTime,
    String? lastTime,
    bool? isProduct,

    List<Person>? casting,
    List<String>? videos,
    List<String>? images,


  }) {
    return Serie (
      id : id ?? this.id,
      name : name ?? this.name,
      description : description ?? this.description,
      posterPath : posterPath ?? this.posterPath,
      genres : genres ?? this.genres,
      seasons: seasons ?? this.seasons,
      vote: vote ?? this.vote,
      langue: langue ?? this.langue,
      statut: statut ?? this.statut,
      firstTime: firstTime ?? this.firstTime,
      lastTime: lastTime ?? this.lastTime,
      isProduct: isProduct ?? this.isProduct,

      casting : casting ?? this.casting,
      videos : videos ?? this.videos,
      images : images ?? this.images,
    );
  }

  factory Serie.fromJson(Map<String, dynamic> map) {
    return Serie(
      id: map['id'],
      name: map['name'],
      description: map['overview'],
      posterPath: map['poster_path'],

      seasons: map['number_of_seasons'],
      statut: map['status'],
      langue: map['original_language'],
      firstTime: map['first_air_date'],
      lastTime: map['last_air_date'],
      isProduct: map['in_production'],


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