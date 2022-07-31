import 'package:flutter/material.dart';
import 'package:interviewapp/core/network_info.dart';
import 'package:interviewapp/features/post/data/datasources/comment_remote_data_source.dart';
import 'package:interviewapp/features/post/data/datasources/remote_data_source.dart';
import 'package:interviewapp/features/post/data/repositories/comment_repository_impl.dart';
import 'package:interviewapp/features/post/data/repositories/post_repository_impl.dart';
import 'package:interviewapp/features/post/domain/usecases/comment_usecase.dart';
import 'package:interviewapp/features/post/domain/usecases/get_comments.dart';
import 'package:interviewapp/features/post/domain/usecases/get_post_list.dart';
import 'package:interviewapp/features/post/presentation/bloc/post_bloc.dart';
import 'package:interviewapp/features/post/presentation/pages/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(
          getComments: GetComments(CommentRepositoryImpl(
            networkInfo: NetworkInfoImpl(),
            commentsRemoteDataSource: CommentsRemoteDataSourceImpl(),
            
          ),),
          getPostList: GetPostList(PostRepositoryImpl(
              networkInfo: NetworkInfoImpl(),
              postsRemoteDataSource: PostsRemoteDataSourceImpl(),),
              ),
          addCommentUsecase:AddCommentUsecase(
            CommentRepositoryImpl(networkInfo: NetworkInfoImpl(), commentsRemoteDataSource: CommentsRemoteDataSourceImpl(),)
          )
              ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        // this should be done with the help of dependency injection
        /// I did this to save time
        home: HomePage(),
      ),
    );
  }
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
