import 'package:equatable/equatable.dart';
import 'package:movieapp/models/movie.dart';

class MovieResponse extends Equatable {
  final int page;
  final List<Movie> movies;
  final int totalPages;
  final int totalResult;

  const MovieResponse(
      {required this.page,
      required this.movies,
      required this.totalPages,
      required this.totalResult});

  factory MovieResponse.parserFromJson(Map<String, dynamic> result) {
    return MovieResponse(
      page: result['page'],
      movies: (result['results'] as List)
          .map((e) => Movie.parserFromJson(e))
          .toList(),
      totalPages: result['total_pages'],
      totalResult: result['total_results'],
    );
  }

  @override
  List<Object> get props => [page, movies, totalPages, totalResult];
}
