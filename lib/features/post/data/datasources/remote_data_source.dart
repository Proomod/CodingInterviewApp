import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:interviewapp/features/post/data/models/post_model.dart';
import 'package:interviewapp/features/post/domain/entities/post.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getDataRemote();
}

class PostsRemoteDataSourceImpl extends PostsRemoteDataSource {
  final Dio dio = Dio();
 
  @override
  Future<List<PostModel>> getDataRemote() async {
     List<PostModel> data = [];
    dio.interceptors.add(DioCacheManager(
            CacheConfig(baseUrl: "https://jsonplaceholder.typicode.com"))
        .interceptor);
    try {
      final response = await dio.get(
          'https://jsonplaceholder.typicode.com/posts',
          options:
              buildCacheOptions(const Duration(hours: 1), forceRefresh: true));
      response.data.forEach((d) {
        data.add(PostModelImpl.fromJson(d));
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
}
