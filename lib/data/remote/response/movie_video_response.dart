import 'package:equatable/equatable.dart';
import 'package:movieapp/models/video.dart';

class MovieVideoResponse extends Equatable {
  final int? id;
  final List<Video>? results;

  const MovieVideoResponse({
    this.id,
    this.results,
  });

  factory MovieVideoResponse.parserFromJson(Map<String, dynamic> json) =>
      MovieVideoResponse(
        id: json["id"],
        results: json["results"] == null
            ? []
            : List<Video>.from(json["results"]!.map((x) => Video.fromJson(x))),
      );

  @override
  List<Object?> get props => [id, results];
}
