import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final int? id;
  final String? name;

  const Genre({this.id, this.name});

  factory Genre.parserFromJson(Map<String, dynamic> result) {
    return Genre(
      id: result['id'],
      name: result['name'],
    );
  }

  @override
  List<Object?> get props => [id, name];
}
