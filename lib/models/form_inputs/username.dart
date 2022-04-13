import 'package:formz/formz.dart';

enum UserNameValidationError { invalid }

class UserName extends FormzInput<String, UserNameValidationError> {
  const UserName.pure() : super.pure('');
  const UserName.dirty([String value = '']) : super.dirty(value);

  @override
  UserNameValidationError? validator(String? value) {
    if (value == null) {
      return UserNameValidationError.invalid;
    } else {
      if (value.length < 2) {
        print('password: invalid ');
        return UserNameValidationError.invalid;
      }
      print('password: valid');
      return null;
    }
  }
}
