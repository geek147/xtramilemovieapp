import 'package:movieapp/models/movie_review.dart';

abstract class ReviewState {}

class InitialReview extends ReviewState {}

class LoadingReview extends ReviewState {}

class GetReviewsSuccess extends ReviewState {
  final List<Review> listReview;

  GetReviewsSuccess({required this.listReview});
}

class GetReviewsError extends ReviewState {
  final String message;

  GetReviewsError({required this.message});
}
