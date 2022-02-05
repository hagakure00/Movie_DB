import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:moviedb/Model/Movie.dart';
import 'package:moviedb/Model/Serie.dart';
import 'package:moviedb/Services/Api.dart';

class DataRepository with ChangeNotifier {

  final ApiService apiService = ApiService();

  final List<Movie> _popularMovieList = [];
  int _popularMoviePageIndex = 1;

  final List<Movie> _nowPlaying = [];
  int _nowPlayingPageIndex = 1;

  final List<Movie> _comingMovie = [];
  int _comingMoviePageIndex = 1;

  // categorie
  final List<Movie> _animationMovie = [];
  int _animationMoviePageIndex = 1;
  final List<Movie> _aventureMovie = [];
  int _aventureMoviePageIndex = 1;
  final List<Movie> _comedieMovie = [];
  int _comedieMoviePageIndex = 1;
  final List<Movie> _thrillerMovie = [];
  int _thrillerMoviePageIndex = 1;
  final List<Movie> _fictionMovie = [];
  int _fictionMoviePageIndex = 1;

  final List<Serie> _popularSerieList = [];
  int _popularSeriePageIndex = 1;
  final List<Serie> _topSerieList = [];
  int _topSeriePageIndex = 1;

  final List<Movie> _searchMovie = [];
  List<Movie> get searchMovie => _searchMovie;
  final List<Serie> _searchSerie = [];
  List<Serie> get searchSerie => _searchSerie;

  // getters
List<Movie> get popularMovieList => _popularMovieList;
List<Movie> get nowPlaying => _nowPlaying;
List<Movie> get comingMovie => _comingMovie;

// categorie
List<Movie> get animationMovies => _animationMovie;
List<Movie> get aventureMovies => _aventureMovie;
List<Movie> get comedieMovies => _comedieMovie;
List<Movie> get thrillerMovies => _thrillerMovie;
List<Movie> get fictionMovies => _fictionMovie;

List<Serie> get popularSerieList => _popularSerieList;
List<Serie> get topSerieList => _topSerieList;


Future <void> getPopularSeries() async {
    try {
      List<Serie> series = await apiService.getPopularSeries(pageNumber: _popularSeriePageIndex);
      _popularSerieList.addAll(series);
      _popularSeriePageIndex++ ;
      notifyListeners();
    } on Response catch (response){
      if (kDebugMode) {
        print("erreur ${response.statusCode}");
        rethrow;
      }
    }
  }
Future <void> getTopSeries() async {
    try {
      List<Serie> series = await apiService.getTopSeries(pageNumber: _topSeriePageIndex);
      _topSerieList.addAll(series);
      _topSeriePageIndex++ ;
      notifyListeners();
    } on Response catch (response){
      if (kDebugMode) {
        print("erreur ${response.statusCode}");
        rethrow;
      }
    }
  }

Future <void> getPopularMovies() async {
  try {
    List<Movie> movies = await apiService.getPopularMovies(pageNumber: _popularMoviePageIndex);
    _popularMovieList.addAll(movies);
    _popularMoviePageIndex++ ;
    notifyListeners();
  } on Response catch (response){
    if (kDebugMode) {
      print("erreur ${response.statusCode}");
      rethrow;
    }
  }
}
Future <void> getNowPlaying() async {
    try {
      List<Movie> movies = await apiService.getNowPlaying(pageNumber: _nowPlayingPageIndex);
      _nowPlaying.addAll(movies);
      _nowPlayingPageIndex++ ;
      notifyListeners();
    } on Response catch (response){
      if (kDebugMode) {
        print("erreur ${response.statusCode}");
        rethrow;
      }
    }
  }
Future <void> getComingMovies() async {
    try {
      List<Movie> movies = await apiService.getComingMovies(pageNumber: _comingMoviePageIndex);
      _comingMovie.addAll(movies);
      _comingMoviePageIndex++ ;
      notifyListeners();
    } on Response catch (response){
      if (kDebugMode) {
        print("erreur ${response.statusCode}");
        rethrow;
      }
    }
  }

// categorie
Future <void> getAnimationMovies() async {
    try {
      List<Movie> movies = await apiService.getAnimationMovies(pageNumber: _animationMoviePageIndex);
      _animationMovie.addAll(movies);
      _animationMoviePageIndex++ ;
      notifyListeners();
    } on Response catch (response){
      if (kDebugMode) {
        print("erreur ${response.statusCode}");
        rethrow;
      }
    }
  }
Future <void> getAventureMovies() async {
    try {
      List<Movie> movies = await apiService.getAventureMovies(pageNumber: _aventureMoviePageIndex);
      _aventureMovie.addAll(movies);
      _aventureMoviePageIndex++ ;
      notifyListeners();
    } on Response catch (response){
      if (kDebugMode) {
        print("erreur ${response.statusCode}");
        rethrow;
      }
    }
  }
Future <void> getComedieMovies() async {
    try {
      List<Movie> movies = await apiService.getComedieMovies(pageNumber: _comedieMoviePageIndex);
      _comedieMovie.addAll(movies);
      _comedieMoviePageIndex++ ;
      notifyListeners();
    } on Response catch (response){
      if (kDebugMode) {
        print("erreur ${response.statusCode}");
        rethrow;
      }
    }
  }
Future <void> getThrillerMovies() async {
    try {
      List<Movie> movies = await apiService.getThrillerMovies(pageNumber: _thrillerMoviePageIndex);
      _thrillerMovie.addAll(movies);
      _thrillerMoviePageIndex++ ;
      notifyListeners();
    } on Response catch (response){
      if (kDebugMode) {
        print("erreur ${response.statusCode}");
        rethrow;
      }
    }
  }
Future <void> getFictionMovies() async {
    try {
      List<Movie> movies = await apiService.getFictionMovies(pageNumber: _fictionMoviePageIndex);
      _fictionMovie.addAll(movies);
      _fictionMoviePageIndex++ ;
      notifyListeners();
    } on Response catch (response){
      if (kDebugMode) {
        print("erreur ${response.statusCode}");
        rethrow;
      }
    }
  }


Future<Movie> getMovieDetails({required Movie movie}) async {
  try{
    // recuperer info du film
    Movie newMovie = await apiService.getMovieDetails(movie: movie);
    // recuperer les video
    newMovie = await apiService.getMovieVideo(movie: newMovie);
    // recuperer casting
    newMovie = await apiService.getMovieCast(movie: newMovie);
    // recuperer images
    newMovie = await apiService.getImageMovie(movie: newMovie);

    return newMovie;
  } on Response catch (response) {
    print("erreur ${response.statusCode}");
    rethrow;
  }
}
Future<Serie> getSerieDetails({required Serie serie}) async {
    try{
      // recuperer info du film
      Serie newSerie = await apiService.getSerieDetails(serie: serie);
      // recuperer les video
      newSerie = await apiService.getSerieVideo(serie: newSerie);
      // recuperer casting
      newSerie = await apiService.getSerieCast(serie: newSerie);
      // recuperer images
      newSerie = await apiService.getImageSerie(serie: newSerie);

      return newSerie;
    } on Response catch (response) {
      print("erreur ${response.statusCode}");
      rethrow;
    }
  }


Future <void> getSearchMovies({required String key}) async {
    try {
      List<Movie> movies = await apiService.getSearchMovies(query: key);
      _searchMovie.addAll(movies);
      notifyListeners();
    } on Response catch (response){
      if (kDebugMode) {
        print("erreur ${response.statusCode}");
        rethrow;
      }
    }
  }
Future <void> getSearchSeries({required String key}) async {
    try {
      List<Serie> series = await apiService.getSearchSeries(query: key);
      _searchSerie.addAll(series);
      notifyListeners();
    } on Response catch (response){
      if (kDebugMode) {
        print("erreur ${response.statusCode}");
        rethrow;
      }
    }
  }

Future <void> iniData() async {
  await Future.wait([
     getPopularMovies(),
     getNowPlaying(),
     getComingMovies(),

     getAnimationMovies(),
     getAventureMovies(),
     getComedieMovies(),
     getThrillerMovies(),
     getFictionMovies(),

    getPopularSeries(),
    getTopSeries(),
  ]);
}




}