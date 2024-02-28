abstract class MovieEvent {}

class GetGenresEvent extends MovieEvent {}

class GetMovieInfoEvent extends MovieEvent {
  final int movieId;

  GetMovieInfoEvent({required this.movieId});
}

class GetMoviesByGenreEvent extends MovieEvent {
  final String genre;
  final int page;

  GetMoviesByGenreEvent({required this.genre, required this.page});
}
