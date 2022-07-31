import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewapp/features/post/domain/entities/post.dart';
import 'package:interviewapp/features/post/domain/usecases/comment_usecase.dart';

import 'package:interviewapp/features/post/presentation/bloc/post_bloc.dart';

class DetailPostPage extends StatefulWidget {
  final PostModel post;
  const DetailPostPage({required this.post, Key? key}) : super(key: key);

  @override
  State<DetailPostPage> createState() => _DetailPostPageState();
}

class _DetailPostPageState extends State<DetailPostPage> {
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(FetchComments(widget.post.id));
  }

  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              title: Text(
            widget.post.title,
            maxLines: 1,
            overflow: TextOverflow.fade,
          )),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.post.title,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            )),
                        const SizedBox(height: 10),
                        Text('27 july 4:23 pm',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(color: Colors.grey)),
                        const SizedBox(height: 10),
                        Text(widget.post.body),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                  if (state.comments.isNotEmpty) ...[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Comments",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text("View all"),
                          ),
                        ]),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                      child: ListView.builder(
                        itemCount: state.comments.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (contex, index) {
                          final comment = state.comments[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Name: ${comment.name}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 3),
                                    Text(comment.email,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.italic)),
                                    SizedBox(height: 3),
                                    Text(comment.body),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    )
                  ] else
                    Text('No comments')
                ],
              ),
            ),
          ),
          bottomSheet: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10.0)),
            height: MediaQuery.of(context).size.height * .06,
            width: double.infinity,
            child: Center(
              child: TextField(
                controller: _commentController,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Add comment",
                  suffixIcon: IconButton(
                      onPressed: () {
                        if (_commentController.text == '') return;
                        final postReq = CommentRequestModel(
                            widget.post.id, _commentController.text);
                        context.read<PostBloc>().add(AddComment(postReq));
                        _commentController.clear();
                      },
                      icon: const Icon(Icons.send)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                  isDense: true,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
