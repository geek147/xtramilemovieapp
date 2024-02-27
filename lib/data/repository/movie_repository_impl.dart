import 'package:movieapp/core/request.dart';
import 'package:movieapp/core/service_locator.dart';
import 'package:movieapp/data/movie_repository.dart';
import 'package:movieapp/data/remote/response/genres_response.dart';
import 'package:movieapp/data/remote/response/movie_response.dart';
import 'package:movieapp/data/remote/response/movie_review_response.dart';
import 'package:movieapp/data/remote/response/movie_video_response.dart';
import 'package:movieapp/models/genre.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/models/movie_info.dart';
import 'package:movieapp/models/movie_review.dart';
import 'package:movieapp/models/video.dart';
import 'package:movieapp/util/strings.dart';

class MovieRepositoryImpl extends MovieRepository {
  @override
  Future<List<Movie>> getMoviesByGenre(String genre) async {
    final Request request = serviceLocator<Request>();
    final Map<String, dynamic> query = {
      'api_key': apiKey,
      'language': movieLanguage,
      'page': 1,
      'with_genres': genre,
    };
    final response = await request.get("/3/discover/movie", query);
    if (response.statusCode == 200) {
      return MovieResponse.parserFromJson(response.data).movies;
    } else {
      throw Exception('Fail to load movie by genre');
    }
  }

  @override
  Future<MovieInfo> getMovieInfo(int movieId) async {
    final Request request = serviceLocator<Request>();
    final Map<String, dynamic> query = {
      'api_key': apiKey,
      'language': movieLanguage,
      'page': 1
    };
    final response = await request.get('/3/movie/$movieId', query);
    if (response.statusCode == 200) {
      return MovieInfo.parserFromJson(response.data);
    } else {
      throw Exception('Fail to load movie info');
    }
  }

  @override
  Future<List<Genre>> getGenres() async {
    final Request request = serviceLocator<Request>();
    final Map<String, dynamic> query = {
      'api_key': apiKey,
      'language': movieLanguage,
      'page': 1
    };

    final response = await request.get("/3/genre/movie/list", query);

    if (response.statusCode == 200) {
      final genres = GenresResponse.parserFromJson(response.data).genres;

      return genres ?? [];
    } else {
      throw Exception('Fail to load genre movie');
    }
  }

  @override
  Future<List<Review>> getReviews(int movieId) async {
    final Request request = serviceLocator<Request>();
    final Map<String, dynamic> query = {
      'api_key': apiKey,
      'language': movieLanguage,
      'page': 1
    };
    final response = await request.get('/3/movie/$movieId/reviews', query);
    if (response.statusCode == 200) {
      final movieReview =
          MovieReviewsResponse.parserFromJson(response.data).results;

      return movieReview ?? [];
    } else {
      throw Exception('Fail to load movie reviews');
    }
  }

  @override
  Future<List<Video>> getVideos(int movieId) async {
    final Request request = serviceLocator<Request>();
    final Map<String, dynamic> query = {
      'api_key': apiKey,
      'language': movieLanguage,
      'page': 1
    };
    final response = await request.get('/3/movie/$movieId/videos', query);
    if (response.statusCode == 200) {
      final movieVideo =
          MovieVideoResponse.parserFromJson(response.data).results;

      return movieVideo ?? [];
    } else {
      throw Exception('Fail to load movie video');
    }
  }
}
