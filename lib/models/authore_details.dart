import 'package:equatable/equatable.dart';

class AuthorDetails extends Equatable {
  final String? name;
  final String? username;
  final String? avatarPath;
  final int? rating;

  const AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  factory AuthorDetails.fromJson(Map<String, dynamic> result) => AuthorDetails(
        name: result["name"],
        username: result["username"],
        avatarPath: result["avatar_path"],
        rating: result["rating"],
      );

  @override
  List<Object?> get props => [name, username, avatarPath, rating];
}
