import 'package:interviewapp/core/network_info.dart';
import 'package:interviewapp/features/post/data/datasources/comment_remote_data_source.dart';
import 'package:interviewapp/features/post/domain/entities/comment.dart';
import 'package:interviewapp/core/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:interviewapp/features/post/domain/repositories/comment_repository.dart';

class CommentRepositoryImpl extends CommentRepository {
  final NetworkInfo _networkInfo;
  final CommentsRemoteDataSource _commentsRemoteDataSource;
  CommentRepositoryImpl(
      {required NetworkInfo networkInfo,
      required CommentsRemoteDataSource commentsRemoteDataSource})
      : _networkInfo = networkInfo,
        _commentsRemoteDataSource = commentsRemoteDataSource;

  @override
  Future<Either<Failure, List<CommentModel>>> getComments(num postId) async {
    // if (await _networkInfo.isConnected) {
    try {
      final comments = await _commentsRemoteDataSource.getDataRemote(postId);
      return Right(comments);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
    // } // implement cache here
    // return Left(CacheFailure());
  }

  @override
  Future<Either<Failure, bool>> addComment(num postId, String comment) async {
    if (await _networkInfo.isConnected) {
      try {
        final success =
            await _commentsRemoteDataSource.addComment(postId, comment);
        return Right(success);
      } catch (e) {
        return Left(NetworkFailure(e.toString()));
      }
    } else {
      //TODO: fetch from local datasource
      return Left(CacheFailure());
    }
  }
}
