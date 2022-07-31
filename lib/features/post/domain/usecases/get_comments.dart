import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:interviewapp/core/errors/errors.dart';
import 'package:interviewapp/core/usecases.dart';
import 'package:interviewapp/features/post/domain/entities/comment.dart';
import 'package:interviewapp/features/post/domain/repositories/comment_repository.dart';

class GetComments extends UseCases<List<CommentModel>, Params> {
  final CommentRepository _commentRepository;
  GetComments(CommentRepository commentRepository)
      : _commentRepository = commentRepository;
  @override
  Future<Either<Failure, List<CommentModel>>> call(Params data) async {
    return await _commentRepository.getComments(data.postId);
  } 
}

class Params extends Equatable {
  const Params(this.postId);
  final num postId;
  @override
  List<Object?> get props => [postId];
}
