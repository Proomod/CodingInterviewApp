import 'package:equatable/equatable.dart';

class CommentModel extends Equatable {
  final num postId;
  final num id;
  final String name;
  final String email;
  final String body;

  const CommentModel(
      {required this.postId,
      required this.id,
      required this.name,
      required this.email,
      required this.body});

  @override
  List<Object?> get props => [postId, id, name, email, body];
}
