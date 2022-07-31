abstract class Failure {}

class NetworkFailure extends Failure {
  /// will implement network exception later in the code if extension
  /// is needed
  String error = 'Something is wrong with network';

  NetworkFailure(this.error);
}

class CacheFailure extends Failure {}
