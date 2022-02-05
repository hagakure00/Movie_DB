import 'package:moviedb/Model/Movie.dart';
import 'package:moviedb/Model/Person.dart';
import 'package:moviedb/Model/Serie.dart';
import 'package:moviedb/Services/ApiKey.dart';
import 'package:dio/dio.dart';

class Api {
  final String apiKey = ApiKey.apikey;
  final String baseUrl = "https://api.themoviedb.org/3";
  final String baseImageUrl = "https://image.tmdb.org/t/p/w500/";
  final String baseVideoUrl = "https://www.youtube.com/watch?v=";
}

class ApiService {
  final Api api = Api();
  final Dio dio = Dio();

  Future<Response> getData (String path, {Map<String,dynamic>? params}) async{
   // construction url
    String _url = api.baseUrl + path;

    // construction des parametre de la requete
    Map<String, dynamic> query = {
      'api_key': api.apiKey,
      'language': 'fr-FR',
    };

    // si params n'est pas null, on ajoute le contenu a query
    if(params != null) {
      query.addAll(params);
    }

    // appel final : url + parametre
    final response = await dio.get(_url, queryParameters: query);

    // verification  de la requete
    if(response.statusCode == 200) {
      return response;
    } else {
      throw response;
    }
  }

  Future <List<Movie>> getSearchMovies({required String query}) async {
    Response response = await getData('/search/movie',params: {
     // 'page' : pageNumber,
      'query' : query,
    });

    // verification  de la requete
    if (response.statusCode == 200) {
      Map data = response.data;
      List <dynamic> results = data['results'];
      List<Movie> movies = [];
      for(Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }
      return movies;
    } else {
      throw response;
    }
  }
  Future <List<Serie>> getSearchSeries({required String query}) async {
    Response response = await getData('/search/tv',params: {
      // 'page' : pageNumber,
      'query' : query,
    });

    // verification  de la requete
    if (response.statusCode == 200) {
      Map data = response.data;
      List <dynamic> results = data['results'];
      List<Serie> series = [];
      for(Map<String, dynamic> json in results) {
        Serie serie = Serie.fromJson(json);
        series.add(serie);
      }
      return series;
    } else {
      throw response;
    }
  }


  Future <List<Serie>> getPopularSeries({required int pageNumber}) async {

    Response response = await getData('/tv/popular',params: {
      'page' : pageNumber,
    });

    // verification  de la requete
    if (response.statusCode == 200) {
      Map data = response.data;
      List <dynamic> results = data['results'];
      List<Serie> series = [];
      for(Map<String, dynamic> json in results) {
        Serie serie = Serie.fromJson(json);
        series.add(serie);
      }
      return series;
    } else {
      throw response;
    }
  }
  Future <List<Serie>> getTopSeries({required int pageNumber}) async {

    Response response = await getData('/tv/top_rated',params: {
      'page' : pageNumber,
    });

    // verification  de la requete
    if (response.statusCode == 200) {
      Map data = response.data;
      List <dynamic> results = data['results'];
      List<Serie> series = [];
      for(Map<String, dynamic> json in results) {
        Serie serie = Serie.fromJson(json);
        series.add(serie);
      }
      return series;
    } else {
      throw response;
    }
  }


  Future<Serie> getSerieDetails({required Serie serie}) async {
    Response response = await getData('/tv/${serie.id}');
    if (response.statusCode == 200) {
      Map<String, dynamic> _data = response.data;

      // recuperer genre et mettre en list
      var genres = _data['genres'] as List;
      List<String> genreList = genres.map((item) {
        return item['name'] as String;
      }).toList();

      Serie newSerie = serie.copyWith(
        genres: genreList,
        seasons: _data['number_of_seasons'],
        vote: _data['vote_average'],
        statut: _data['status'],
        langue: _data['original_language'],
        firstTime: _data['first_air_date'],
        lastTime: _data['last_air_date'],
        isProduct: _data['in_production'],
      );
      return newSerie;
    } else {
      throw response;
    }
  }
  Future<Serie> getSerieCast({required Serie serie}) async {
    Response response = await getData('/tv/${serie.id}/credits');

    // verification  de la requete
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Person> _casting = data['cast'].map<Person>((dynamic personJson) {
        return Person.fromJson(personJson);
      }).toList();

      return serie.copyWith(casting: _casting);
    } else {
      throw response;
    }
  }
  Future<Serie> getSerieVideo({required Serie serie}) async {
    Response response = await getData('/tv/${serie.id}/videos');

    // verification  de la requete
    if (response.statusCode == 200) {
      Map _data = response.data;
      List<String> videoKeys = _data['results'].map<String>((dynamic videoJson) {
        return videoJson['key'] as String;
      }).toList();
      return serie.copyWith(videos: videoKeys);
    } else {
      throw response;
    }
  }
  Future<Serie> getImageSerie({required Serie serie}) async {
    Response response = await getData('/tv/${serie.id}/images',params: {
      'include_image_language': 'null',
    });
    // verification  de la requete
    if (response.statusCode == 200) {
      Map data = response.data;
      List<String> imagePath = data['backdrops'].map<String>((dynamic imageJson) {
        return imageJson['file_path'] as String;
      }).toList();
      return serie.copyWith(
        images: imagePath,
      );
    } else {
      throw response;
    }

  }


  Future <List<Movie>> getPopularMovies({required int pageNumber}) async {

    Response response = await getData('/movie/popular',params: {
      'page' : pageNumber,
    });

    // verification  de la requete
    if (response.statusCode == 200) {
      Map data = response.data;
      List <dynamic> results = data['results'];
      List<Movie> movies = [];
      for(Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }
      return movies;
     } else {
      throw response;
    }
  }
  Future <List<Movie>> getNowPlaying({required int pageNumber}) async {

    Response response = await getData('/movie/now_playing',params: {
      'page' : pageNumber,
    });

    // verification  de la requete
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }
  Future <List<Movie>> getComingMovies({required int pageNumber}) async {

    Response response = await getData('/movie/upcoming',params: {
      'page' : pageNumber,
    });

    // verification  de la requete
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }
  Future <List<Movie>> getAnimationMovies({required int pageNumber}) async {
    Response response = await getData('/discover/movie/',params: {
      'page' : pageNumber,
      'with_genres': '16'
    });

    // verification  de la requete
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }
  Future <List<Movie>> getAventureMovies({required int pageNumber}) async {
    Response response = await getData('/discover/movie/',params: {
      'page' : pageNumber,
      'with_genres': '12'
    });

    // verification  de la requete
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }
  Future <List<Movie>> getComedieMovies({required int pageNumber}) async {
    Response response = await getData('/discover/movie/',params: {
      'page' : pageNumber,
      'with_genres': '35'
    });

    // verification  de la requete
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }
  Future <List<Movie>> getThrillerMovies({required int pageNumber}) async {
    Response response = await getData('/discover/movie/',params: {
      'page' : pageNumber,
      'with_genres': '53'
    });

    // verification  de la requete
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }


Future <List<Movie>> getFictionMovies({required int pageNumber}) async {
    Response response = await getData('/discover/movie/',params: {
      'page' : pageNumber,
      'with_genres': '878'
    });

    // verification  de la requete
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }
Future<Movie> getMovieDetails({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}');
    if (response.statusCode == 200) {
      Map<String, dynamic> _data = response.data;

      // recuperer genre et mettre en list
      var genres = _data['genres'] as List;
      List<String> genreList = genres.map((item) {
        return item['name'] as String;
      }).toList();

      Movie newMovie = movie.copyWith(
        genres: genreList,
        releaseDate: _data['release_date'],
        vote: _data['vote_average'],
        langue: _data['original_language'],
        budget: _data['budget'],
        revenu: _data['revenue'],
        time: _data['runtime'],
      );
      return newMovie;
    } else {
      throw response;
    }
}
Future<Movie> getMovieVideo({required Movie movie}) async {
   Response response = await getData('/movie/${movie.id}/videos');

   // verification  de la requete
   if (response.statusCode == 200) {
     Map _data = response.data;
     List<String> videoKeys = _data['results'].map<String>((dynamic videoJson) {
      return videoJson['key'] as String;
     }).toList();
      return movie.copyWith(videos: videoKeys);
   } else {
     throw response;
   }
 }
Future<Movie> getMovieCast({required Movie movie}) async {
   Response response = await getData('/movie/${movie.id}/credits');

   // verification  de la requete
   if (response.statusCode == 200) {
     Map data = response.data;
     List<Person> _casting = data['cast'].map<Person>((dynamic personJson) {
       return Person.fromJson(personJson);
     }).toList();

     return movie.copyWith(casting: _casting);
   } else {
     throw response;
   }

 }
Future<Movie> getImageMovie({required Movie movie}) async {
   Response response = await getData('/movie/${movie.id}/images',params: {
     'include_image_language': 'null',
   });
   // verification  de la requete
   if (response.statusCode == 200) {
     Map data = response.data;
     List<String> imagePath = data['backdrops'].map<String>((dynamic imageJson) {
       return imageJson['file_path'] as String;
     }).toList();
     return movie.copyWith(
       images: imagePath,
     );
   } else {
     throw response;
   }

 }

}