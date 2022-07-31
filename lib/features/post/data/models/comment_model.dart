import 'package:flutter/foundation.dart';
import 'package:interviewapp/features/post/domain/entities/comment.dart';

class CommentModelImpl extends CommentModel {
  CommentModelImpl(
      {required num postId,
      required num id,
      required String name,
      required String email,
      required String body})
      : super(postId: postId, id: id, name: name, email: email, body: body);

  factory CommentModelImpl.fromJson(Map<String, dynamic> json) {
    return CommentModelImpl(
        id: json['id'],
        postId: json['postId'],
        name: json['name'],
        email: json['email'],
        body: json['body']);
  }
  toJson() =>
     <String,dynamic>{
      'id':id,
      'postId':postId,
      'name':name,
      'email':email,
      'body':body,
     };

}
