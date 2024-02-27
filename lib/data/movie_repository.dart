import 'package:movieapp/models/genre.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/models/movie_info.dart';
import 'package:movieapp/models/movie_review.dart';
import 'package:movieapp/models/video.dart';

abstract class MovieRepository {
  Future<List<Genre>> getGenres();
  Future<List<Movie>> getMoviesByGenre(String genre);
  Future<MovieInfo> getMovieInfo(int movieId);
  Future<List<Review>> getReviews(int movieId);
  Future<List<Video>> getVideos(int movieId);
}
