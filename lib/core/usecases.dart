import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:interviewapp/core/errors/errors.dart';

abstract class UseCases<T, Params> {
  Future<Either<Failure, T>> call(Params data);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
