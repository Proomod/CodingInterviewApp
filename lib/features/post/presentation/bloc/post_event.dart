part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class FetchPosts extends PostEvent {}

class FetchComments extends PostEvent {
  final num id;
  const FetchComments(this.id);
  @override
  List<Object> get props => [id];
}

class AddComment extends PostEvent {
final  CommentRequestModel requestModel;
  const AddComment(this.requestModel);
  @override
  List<Object> get props => [];
}
