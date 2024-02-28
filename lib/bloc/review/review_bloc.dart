import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/bloc/review/review_event.dart';
import 'package:movieapp/bloc/review/review_state.dart';
import 'package:movieapp/core/service_locator.dart';
import 'package:movieapp/data/movie_repository.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(InitialReview()) {
    on<GetMovieReviewsEvent>((event, emit) async {
      try {
        if (event.page == 1) {
          emit(LoadingReview());
        }

        final result = await serviceLocator<MovieRepository>()
            .getReviews(event.movieId, event.page);
        emit(GetReviewsSuccess(listReview: result));
      } catch (e) {
        emit(GetReviewsError(message: e.toString()));
      }
    });
  }
}
