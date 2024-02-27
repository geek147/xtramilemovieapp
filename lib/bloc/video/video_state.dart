import 'package:movieapp/models/video.dart';

abstract class VideoState {}

class InitialVideo extends VideoState {}

class LoadingVideo extends VideoState {}

class GetVideosSuccess extends VideoState {
  final List<Video> listVideo;

  GetVideosSuccess({required this.listVideo});
}

class GetVideosError extends VideoState {
  final String message;

  GetVideosError({required this.message});
}
