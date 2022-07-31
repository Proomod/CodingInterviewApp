import 'package:equatable/equatable.dart';

class PostModel  extends Equatable{
  final num userId;
  final num id;
  final String body;
  final String title;
  PostModel({
    required this.userId,
    required this.id,
    required this.body,
    required this.title,
  });

  @override
  List<Object?> get props => [userId,id,body,title];
}
