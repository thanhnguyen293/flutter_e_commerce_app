import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models/form_inputs/email.dart';
import '../../models/form_inputs/password.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.passwordHide = true,
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final bool passwordHide;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [email, password, passwordHide, status];

  LoginState copyWith({
    Email? email,
    Password? password,
    bool? passwordHide,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordHide: passwordHide ?? this.passwordHide,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
