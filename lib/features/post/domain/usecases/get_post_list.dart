
import 'package:interviewapp/core/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:interviewapp/core/usecases.dart';
import 'package:interviewapp/features/post/domain/entities/post.dart';
import 'package:interviewapp/features/post/domain/repositories/post_repository.dart';

class GetPostList extends UseCases<List<PostModel>, NoParams> {
  final PostRepository _postRepository;
  GetPostList(PostRepository postRepository) : _postRepository = postRepository;
  @override
  Future<Either<Failure, List<PostModel>>> call(NoParams data) async {
    return await _postRepository.getAllPost();
  }
}
