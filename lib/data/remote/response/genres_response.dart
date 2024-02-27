import 'package:equatable/equatable.dart';
import 'package:movieapp/models/genre.dart';

class GenresResponse extends Equatable {
  final List<Genre>? genres;

  const GenresResponse({
    this.genres,
  });

  factory GenresResponse.parserFromJson(Map<String, dynamic> json) =>
      GenresResponse(
        genres: json["genres"] == null
            ? []
            : List<Genre>.from(
                json["genres"]!.map((x) => Genre.parserFromJson(x))),
      );

  @override
  List<Object?> get props => [genres];
}
