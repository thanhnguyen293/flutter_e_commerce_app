import 'package:equatable/equatable.dart';
import 'package:flutter_e_commerce_app/models/form_inputs/username.dart';
import 'package:formz/formz.dart';

import '../../models/form_inputs/confirmed_password.dart';
import '../../models/form_inputs/email.dart';
import '../../models/form_inputs/password.dart';

enum ConfirmPasswordValidationError { invalid }

class SignUpState extends Equatable {
  const SignUpState({
    this.username = const UserName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });
  final UserName username;
  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props =>
      [username, email, password, confirmedPassword, status];

  SignUpState copyWith({
    UserName? username,
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return SignUpState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
