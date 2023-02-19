import 'package:equatable/equatable.dart';

abstract class FailureException extends Equatable {
  final String message;

  FailureException(this.message);

  @override
  List<Object> get props => [message];
}

class FailureServerException extends FailureException {
  FailureServerException(String message) : super(message);
}

class FailureConnectionException extends FailureException {
  FailureConnectionException(String message) : super(message);
}

class FailureDatabaseException extends FailureException {
  FailureDatabaseException(String message) : super(message);
}
