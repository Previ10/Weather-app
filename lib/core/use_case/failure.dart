import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class UnhandledFailure extends Failure {
  const UnhandledFailure({required super.message});
}

class AccountNotSetUpFailure extends Failure {
  const AccountNotSetUpFailure() : super(message: "Cuenta no configurada");
}
