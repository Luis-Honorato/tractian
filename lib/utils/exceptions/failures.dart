import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;
  final StackTrace? stackTrace;

  const Failure({required this.errorMessage, this.stackTrace});

  @override
  List<Object?> get props => [errorMessage, stackTrace];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.errorMessage});
}
