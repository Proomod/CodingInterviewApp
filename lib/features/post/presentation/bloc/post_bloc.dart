import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:interviewapp/core/errors/errors.dart';
import 'package:interviewapp/core/usecases.dart';
import 'package:interviewapp/features/post/data/models/comment_model.dart';
import 'package:interviewapp/features/post/domain/entities/comment.dart';
import 'package:interviewapp/features/post/domain/entities/post.dart';
import 'package:interviewapp/features/post/domain/usecases/comment_usecase.dart';
import 'package:interviewapp/features/post/domain/usecases/get_comments.dart';
import 'package:interviewapp/features/post/domain/usecases/get_post_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostList _getPostList;
  final GetComments _getComments;
  final AddCommentUsecase addCommentUsecase;
  final NoParams novalue = NoParams();

  PostBloc(
      {required GetPostList getPostList,
      required GetComments getComments,
      required this.addCommentUsecase})
      : _getPostList = getPostList,
        _getComments = getComments,
        super(const PostState._()) {
    on<FetchPosts>((event, emit) async {
      await eventToStateFetchPosts(event, emit);
    });
    on<FetchComments>((event, emit) async {
      await eventToStateFetchComments(event, emit);
    });
    on<AddComment>(_onAddComment);
  }

  eventToStateFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    final postList = await _getPostList(novalue);
    postList.fold(
        (l) => {
              if (l is NetworkFailure)
                emit(PostState.error(errorMessage: l.error))
            },
        (r) => emit(PostState.postFetched(r)));
  }

  eventToStateFetchComments(
      FetchComments event, Emitter<PostState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    final comments = await _getComments(Params(event.id));
    comments.fold((l) {
      if (l is NetworkFailure) emit(state.copyWith(errorMessage: l.error));
    }, (r) {
      if (prefs.containsKey('localComments')) {
        List<String> savedComments = prefs.getStringList('localComments')!;
        List<CommentModel> neComments = List<CommentModel>.from(
            savedComments.map((e) => CommentModelImpl.fromJson(jsonDecode(e))));
        List<CommentModel> postComments = neComments
            .where(
              (element) => element.postId == event.id,
            )
            .toList();

        emit(state.copyWith(ncomments: [...r, ...postComments]));
      } else
        emit(state.copyWith(ncomments: r));
    });
  }

  void _onAddComment(AddComment event, Emitter<PostState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    final successOrFailure = await addCommentUsecase(event.requestModel);
    successOrFailure.fold((l) {}, (r) {
      final CommentModelImpl newComment = CommentModelImpl(
          postId: event.requestModel.postId,
          id: 1,
          name: "Pramod Bhusal",
          email: "promod.max@gmil.com",
          body: event.requestModel.comment);
      if (prefs.containsKey('localComments')) {
        List<String> oldSavedComments = prefs.getStringList('localComments')!;
        prefs.setStringList('localComments',
            [...oldSavedComments, jsonEncode(newComment.toJson())]);
      } else
        // ignore: curly_braces_in_flow_control_structures
        prefs.setStringList('localComments', [jsonEncode(newComment.toJson())]);
      emit(state.copyWith(ncomments: [...state.comments, newComment]));
    });
  }
}
