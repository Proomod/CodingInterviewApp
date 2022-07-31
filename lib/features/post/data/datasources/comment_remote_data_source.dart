import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:interviewapp/features/post/data/models/comment_model.dart';
import 'package:interviewapp/features/post/domain/entities/comment.dart';

abstract class CommentsRemoteDataSource {
  Future<List<CommentModel>> getDataRemote(num postId);
  Future<bool> addComment(num postId, String comment);
}

class CommentsRemoteDataSourceImpl extends CommentsRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<List<CommentModel>> getDataRemote(num postId) async {
    List<CommentModel> data = [];
    dio.interceptors.add(DioCacheManager(
            CacheConfig(baseUrl: "https://jsonplaceholder.typicode.com"))
        .interceptor);
    try {
      final response = await dio.get(
          'https://jsonplaceholder.typicode.com/posts/$postId/comments',
          options: buildCacheOptions(Duration(hours: 1),
              forceRefresh: true, subKey: postId.toString()));
      response.data.forEach((d) {
        data.add(CommentModelImpl.fromJson(d));
      });
      return data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> addComment(num postId, String comment) async {
    try {
      final response = await dio.post(
        'https://jsonplaceholder.typicode.com/posts/$postId/comments',
        options: Options(contentType: 'application/json'),
        data: {
          "body": comment,
        },
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }
}
