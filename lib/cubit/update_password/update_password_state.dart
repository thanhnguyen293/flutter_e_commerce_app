part of 'update_password_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class UpdatePasswordState extends Equatable {
  const UpdatePasswordState({
    this.currentPassword = const Password.pure(),
    this.newPassword = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Password currentPassword;
  final Password newPassword;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props =>
      [currentPassword, newPassword, confirmedPassword, status];

  UpdatePasswordState copyWith({
    Password? currentPassword,
    Password? newPassword,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return UpdatePasswordState(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
