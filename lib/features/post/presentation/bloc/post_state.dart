part of 'post_bloc.dart';

class PostState extends Equatable {
  final List<PostModel> posts;
  final bool hasError;
  final String errorMessage;
  final List<CommentModel> comments;

  const PostState._(
      {this.posts = const [],
      this.comments = const [],
      this.hasError = false,
      this.errorMessage = ''});
  const PostState.postFetched(List<PostModel> newPosts)
      : this._(
          posts: newPosts,
        );
  const PostState.error({required String errorMessage})
      : this._(hasError: true, errorMessage: errorMessage);
  PostState copyWith(
          {List<PostModel>? nposts,
          List<CommentModel> ncomments = const [],
          bool? hasError,
          String? errorMessage}) =>
      PostState._(
          posts: nposts ?? this.posts,
          errorMessage: errorMessage ?? this.errorMessage,
          comments: ncomments != [] ? ncomments : this.comments,
          hasError: hasError ?? this.hasError);

  @override
  List<Object> get props => [posts, comments, errorMessage, hasError];
}
