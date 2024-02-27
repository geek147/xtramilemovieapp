import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/bloc/movie/movie_event.dart';
import 'package:movieapp/bloc/movie/movie_state.dart';
import 'package:movieapp/core/service_locator.dart';
import 'package:movieapp/data/movie_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(Initial()) {
    on<GetGenresEvent>((event, emit) async {
      try {
        emit(Loading());

        final result = await serviceLocator<MovieRepository>().getGenres();
        emit(GetGenresSuccess(listGenre: result));
      } catch (e) {
        emit(GetGenresError(message: e.toString()));
      }
    });

    on<GetMoviesByGenreEvent>((event, emit) async {
      try {
        emit(Loading());

        final result = await serviceLocator<MovieRepository>()
            .getMoviesByGenre(event.genre);
        emit(GetMoviesSuccess(listMovie: result));
      } catch (e) {
        emit(GetMoviesError(message: e.toString()));
      }
    });

    on<GetMovieInfoEvent>((event, emit) async {
      try {
        emit(Loading());

        final result =
            await serviceLocator<MovieRepository>().getMovieInfo(event.movieId);
        emit(GetInfoSuccess(movieInfo: result));
      } catch (e) {
        emit(GetInfoError(message: e.toString()));
      }
    });
  }
}
