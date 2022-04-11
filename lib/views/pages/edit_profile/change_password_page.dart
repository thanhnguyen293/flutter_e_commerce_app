import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app/controller/auth_repository.dart';
import 'package:flutter_e_commerce_app/cubit/update_profile/update_password_cubit.dart';
import 'package:flutter_e_commerce_app/models/form_inputs/password.dart';
import 'package:flutter_e_commerce_app/themes/constants.dart';
import 'package:flutter_e_commerce_app/themes/theme.dart';
import 'package:flutter_e_commerce_app/views/widgets/title_text.dart';
import 'package:formz/formz.dart';

import '../../../themes/light_color.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  static const String routeName = '/change-password';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const ChangePasswordPage());
  }

  @override
  Widget build(BuildContext context) {
    context.read<UpdatePasswordCubit>().setDefault();
    return Scaffold(
      appBar: AppBar(
        title: const TitleText(
          text: 'Change Password',
          //color: LightColor.black,
        ),
      ),
      body: BlocListener<UpdatePasswordCubit, UpdatePasswordState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  backgroundColor: LightColor.kPrimaryColor,
                  content: Text(state.errorMessage ?? 'Authentication Failure'),
                ),
              );
          }
          if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  backgroundColor: LightColor.kPrimaryColor,
                  content: Text('Password has been change. Login again !'),
                ),
              );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CurrentPasswordField(),
              SizedBox(height: kDefaultPadding),
              NewPasswordField(),
              SizedBox(height: kDefaultPadding),
              ConfirmPasswordField(),
              SizedBox(height: kDefaultPadding),
              UpdatePasswordButton(),
              SizedBox(height: kDefaultPadding / 2),
              CancelButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrentPasswordField extends StatelessWidget {
  const CurrentPasswordField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(
          text: 'Current Password',
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: kDefaultPadding / 2),
        BlocBuilder<UpdatePasswordCubit, UpdatePasswordState>(
            buildWhen: (previous, current) =>
                previous.currentPassword != current.currentPassword,
            builder: (context, state) {
              return TextField(
                onChanged: (currentPassword) {
                  return context
                      .read<UpdatePasswordCubit>()
                      .currentPasswordChanged(currentPassword);
                },
                decoration: AppTheme.inputDecoration.copyWith(
                  hintText: 'Current Password',
                ),
              );
            }),
      ],
    );
  }
}

class NewPasswordField extends StatelessWidget {
  const NewPasswordField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(
          text: 'New Password',
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(
          height: 10,
        ),
        // BlocListener(listener: listener)

        BlocBuilder<UpdatePasswordCubit, UpdatePasswordState>(
          buildWhen: (previous, current) =>
              (previous.newPassword != current.newPassword),
          builder: (context, state) {
            print('build new password field');
            return TextField(
              onChanged: (newPassword) {
                return context
                    .read<UpdatePasswordCubit>()
                    .newPasswordChanged(newPassword);
              },
              decoration: AppTheme.inputDecoration.copyWith(
                hintText: 'New Password',
                errorText: state.newPassword.pure
                    ? null
                    : state.newPassword.invalid
                        ? 'Password invalid'
                        : null,
              ),
            );
          },
        ),
      ],
    );
  }
}

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(
          text: 'Confirm Password',
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: kDefaultPadding / 2),
        BlocBuilder<UpdatePasswordCubit, UpdatePasswordState>(
            buildWhen: (previous, current) =>
                previous.newPassword != current.newPassword ||
                previous.confirmedPassword != current.confirmedPassword,
            builder: (context, state) {
              print('rebuild Confirm Password');
              return TextField(
                onChanged: (confirmPassword) {
                  return context
                      .read<UpdatePasswordCubit>()
                      .confirmedPasswordChanged(confirmPassword);
                },
                decoration: AppTheme.inputDecoration.copyWith(
                  hintText: 'Confirm Password',
                  errorText: state.confirmedPassword.invalid
                      ? 'Password not match'
                      : null,
                ),
              );
            }),
      ],
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const TitleText(
          text: 'Cancel',
          fontWeight: FontWeight.w600,
          color: LightColor.bgColor,
        ),
        style: AppTheme.textButtonStyle.copyWith(
            backgroundColor: MaterialStateProperty.all(LightColor.grey)),
      ),
    );
  }
}

class UpdatePasswordButton extends StatelessWidget {
  const UpdatePasswordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          context.read<UpdatePasswordCubit>().updateFormSubmitted();
        },
        child: const TitleText(
          text: 'Update Password',
          fontWeight: FontWeight.w600,
          color: LightColor.bgColor,
        ),
        style: AppTheme.textButtonStyle,
      ),
    );
  }
}
