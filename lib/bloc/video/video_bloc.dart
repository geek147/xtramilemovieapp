import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/bloc/video/video_event.dart';
import 'package:movieapp/bloc/video/video_state.dart';
import 'package:movieapp/core/service_locator.dart';
import 'package:movieapp/data/movie_repository.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(InitialVideo()) {
    on<GetMovieVideosEvent>((event, emit) async {
      try {
        emit(LoadingVideo());

        final result =
            await serviceLocator<MovieRepository>().getVideos(event.movieId);
        emit(GetVideosSuccess(listVideo: result));
      } catch (e) {
        emit(GetVideosError(message: e.toString()));
      }
    });
  }
}
