import 'package:movieapp/models/genre.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/models/movie_info.dart';

abstract class MovieState {}

class Initial extends MovieState {}

class Loading extends MovieState {}

class GetMoviesSuccess extends MovieState {
  final List<Movie> listMovie;

  GetMoviesSuccess({required this.listMovie});
}

class GetGenresSuccess extends MovieState {
  final List<Genre> listGenre;

  GetGenresSuccess({required this.listGenre});
}

class GetMoviesError extends MovieState {
  final String message;

  GetMoviesError({required this.message});
}

class GetGenresError extends MovieState {
  final String message;

  GetGenresError({required this.message});
}

class GetInfoSuccess extends MovieState {
  final MovieInfo movieInfo;

  GetInfoSuccess({required this.movieInfo});
}

class GetInfoError extends MovieState {
  final String message;

  GetInfoError({required this.message});
}
