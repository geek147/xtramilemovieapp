import 'package:equatable/equatable.dart';
import 'package:movieapp/models/movie_review.dart';

class MovieReviewsResponse extends Equatable {
  final int? id;
  final int? page;
  final List<Review>? results;
  final int? totalPages;
  final int? totalResults;

  const MovieReviewsResponse({
    this.id,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MovieReviewsResponse.parserFromJson(Map<String, dynamic> result) =>
      MovieReviewsResponse(
        id: result["id"],
        page: result["page"],
        results: result["results"] == null
            ? []
            : List<Review>.from(
                result["results"]!.map((x) => Review.parserFromJson(x))),
        totalPages: result["total_pages"],
        totalResults: result["total_results"],
      );

  @override
  List<Object?> get props => [id, page, results, totalPages, totalResults];
}
