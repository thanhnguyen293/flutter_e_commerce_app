import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../controller/auth_repository.dart';
import '../../models/form_inputs/confirmed_password.dart';
import '../../models/form_inputs/password.dart';

part 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit(this._authenticationRepository)
      : super(const UpdatePasswordState());

  final AuthRepository _authenticationRepository;

  void setDefault() {
    emit(
      state.copyWith(
        currentPassword: const Password.pure(),
        newPassword: const Password.pure(),
        confirmedPassword: const ConfirmedPassword.pure(),
        status: FormzStatus.pure,
        errorMessage: null,
      ),
    );
  }

  void currentPasswordChanged(String value) {
    final currentPassword = Password.dirty(value);

    emit(
      state.copyWith(
        currentPassword: currentPassword,
        status: Formz.validate([
          //currentPassword,
          state.newPassword,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  void newPasswordChanged(String value) {
    final newPassword = Password.dirty(value);

    final confirmedPassword = ConfirmedPassword.dirty(
      password: newPassword.value,
      value: state.confirmedPassword.value,
    );

    emit(
      state.copyWith(
        newPassword: newPassword,
        confirmedPassword: confirmedPassword,
        status: Formz.validate([
          //state.currentPassword,
          newPassword,
          confirmedPassword,
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.newPassword.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        status: Formz.validate([
          //state.currentPassword,
          state.newPassword,
          confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> updateFormSubmitted() async {
    print(state.status.isValidated.toString());
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.changePassword(
        newPassword: state.newPassword.value,
        currentPassword: state.currentPassword.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on ChangePasswordFailure catch (e) {
      print('object');
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(status: FormzStatus.submissionFailure),
      );
    }
  }
}
