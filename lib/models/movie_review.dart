import 'package:equatable/equatable.dart';
import 'package:movieapp/models/authore_details.dart';

class Review extends Equatable {
  final String? author;
  final AuthorDetails? authorDetails;
  final String? content;
  final DateTime? createdAt;
  final String? id;
  final DateTime? updatedAt;
  final String? url;

  const Review({
    this.author,
    this.authorDetails,
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  factory Review.parserFromJson(Map<String, dynamic> result) => Review(
        author: result["author"],
        authorDetails: result["author_details"] == null
            ? null
            : AuthorDetails.fromJson(result["author_details"]),
        content: result["content"],
        createdAt: result["created_at"] == null
            ? null
            : DateTime.parse(result["created_at"]),
        id: result["id"],
        updatedAt: result["updated_at"] == null
            ? null
            : DateTime.parse(result["updated_at"]),
        url: result["url"],
      );

  @override
  List<Object?> get props =>
      [author, authorDetails, content, createdAt, id, updatedAt, url];
}
