import 'package:dartz/dartz.dart';
import 'package:interviewapp/core/errors/errors.dart';
import 'package:interviewapp/features/post/domain/entities/post.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostModel>>> getAllPost();
}
