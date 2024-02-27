abstract class ReviewEvent {}

class GetMovieReviewsEvent extends ReviewEvent {
  final int movieId;

  GetMovieReviewsEvent({required this.movieId});
}
