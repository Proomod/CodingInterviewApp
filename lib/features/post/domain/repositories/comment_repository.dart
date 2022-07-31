import 'package:dartz/dartz.dart';
import 'package:interviewapp/core/errors/errors.dart';
import 'package:interviewapp/features/post/domain/entities/comment.dart';

abstract class CommentRepository {
  Future<Either<Failure, List<CommentModel>>> getComments(num postId);
  Future<Either<Failure, bool>> addComment(num postId, String comment);
}
