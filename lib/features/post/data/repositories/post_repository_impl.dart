import 'package:interviewapp/core/network_info.dart';
import 'package:interviewapp/features/post/data/datasources/remote_data_source.dart';
import 'package:interviewapp/features/post/domain/entities/post.dart';
import 'package:interviewapp/core/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:interviewapp/features/post/domain/repositories/post_repository.dart';

class PostRepositoryImpl extends PostRepository {
  final NetworkInfo _networkInfo;
  final PostsRemoteDataSource _postsRemoteDataSource;
  PostRepositoryImpl(
      {required NetworkInfo networkInfo,
      required PostsRemoteDataSource postsRemoteDataSource})
      : _networkInfo = networkInfo,
        _postsRemoteDataSource = postsRemoteDataSource;

  @override
  Future<Either<Failure, List<PostModel>>> getAllPost() async {
    // if (await _networkInfo.isConnected) {
    try {
      final posts = await _postsRemoteDataSource.getDataRemote();

      return Right(posts);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
    // } else {
    //   return Left(CacheFailure());
    // }
  }
}
