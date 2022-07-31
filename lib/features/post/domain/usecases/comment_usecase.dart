
import 'package:interviewapp/core/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:interviewapp/core/usecases.dart';
import 'package:interviewapp/features/post/domain/repositories/comment_repository.dart';

class AddCommentUsecase extends UseCases<bool, CommentRequestModel> {
  final CommentRepository _commentRepository;
  AddCommentUsecase(this._commentRepository);
  @override
  Future<Either<Failure, bool>> call(CommentRequestModel requestModel) async {
    return await _commentRepository.addComment(
        requestModel.postId, requestModel.comment);
  }
}

class CommentRequestModel {
  final num postId;
  final String comment;
  CommentRequestModel(this.postId, this.comment);
}
