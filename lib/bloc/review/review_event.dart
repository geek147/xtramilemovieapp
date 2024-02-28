abstract class ReviewEvent {}

class GetMovieReviewsEvent extends ReviewEvent {
  final int movieId;
  final int page;

  GetMovieReviewsEvent({required this.movieId, required this.page});
}
