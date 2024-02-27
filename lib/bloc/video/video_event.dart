abstract class VideoEvent {}

class GetMovieVideosEvent extends VideoEvent {
  final int movieId;

  GetMovieVideosEvent({required this.movieId});
}
