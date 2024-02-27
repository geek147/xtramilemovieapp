abstract class MovieEvent {}

class GetGenresEvent extends MovieEvent {}

class GetMovieInfoEvent extends MovieEvent {
  final int movieId;

  GetMovieInfoEvent({required this.movieId});
}

class GetMoviesByGenreEvent extends MovieEvent {
  final String genre;

  GetMoviesByGenreEvent({required this.genre});
}
