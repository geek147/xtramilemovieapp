import 'package:equatable/equatable.dart';

class Collection extends Equatable {
  final int? id;
  final String? name;
  final String? posterPath;
  final String? backdropPath;

  const Collection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  });

  factory Collection.parserFromJson(Map<String, dynamic> result) {
    return Collection(
      id: result['id'],
      name: result['name'],
      posterPath: result['poster_path'],
      backdropPath: result['backdrop_path'],
    );
  }

  @override
  List<Object?> get props => [id, name, posterPath, backdropPath];
}
