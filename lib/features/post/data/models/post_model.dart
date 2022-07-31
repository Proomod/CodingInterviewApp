import 'package:interviewapp/features/post/domain/entities/post.dart';

class PostModelImpl extends PostModel {
  PostModelImpl(
      {required num userId,
      required num id,
      required String body,
      required String title})
      : super(userId: userId, id: id, body: body, title: title);

  factory PostModelImpl.fromJson(Map<String, dynamic> json) {
    return PostModelImpl(
        body: json['body'],
        id: json['id'],
        title: json['title'],
        userId: json['userId']);
  }
}
