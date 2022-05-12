import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';

import '../../../themes/constants.dart';
import '../../../themes/theme.dart';
import '../../../views/widgets/title_text.dart';
import '../../../cubit/sign_up/sign_up_cubit.dart';
import '../../../cubit/sign_up/sign_up_state.dart';
import '../../../themes/light_color.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Sign Up Failure'),
                backgroundColor: LightColor.kPrimaryColor,
              ),
            );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFf57a50),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset('assets/images/sign_up.png'),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                  color: LightColor.bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //_UsernameInput(),
                        const TitleText(text: 'SIGN UP'),
                        const SizedBox(height: kDefaultPadding * 2),
                        _UserNameInput(),
                        const SizedBox(height: kDefaultPadding),
                        _EmailInput(),
                        const SizedBox(height: kDefaultPadding),
                        _PasswordInput(),
                        const SizedBox(height: kDefaultPadding),
                        _ConfirmPasswordInput(),
                        const SizedBox(height: kDefaultPadding * 2),
                        _SignUpButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) =>
            current.username.value != previous.username.value,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleText(
                text: 'Full Name',
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: kDefaultPadding / 2),
              TextField(
                key: const Key('signUpForm_FullNameInput_textField'),
                onChanged: (userName) =>
                    context.read<SignUpCubit>().userNameChanged(userName),
                //keyboardType: TextInputType.emailAddress,
                cursorColor: LightColor.kPrimaryColor,
                decoration: AppTheme.inputDecoration.copyWith(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: LightColor.kPrimaryColor,
                  ),
                  hintText: 'Full Name',
                  errorText: state.username.invalid ? 'Invalid username' : null,
                ),
              ),
            ],
          );
        });
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleText(
              text: 'Email',
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: kDefaultPadding / 2),
            TextField(
              key: const Key('signUpForm_emailInput_textField'),
              onChanged: (email) =>
                  context.read<SignUpCubit>().emailChanged(email),
              keyboardType: TextInputType.emailAddress,
              cursorColor: LightColor.kPrimaryColor,
              decoration: AppTheme.inputDecoration.copyWith(
                prefixIcon: const Icon(
                  Icons.email,
                  color: LightColor.kPrimaryColor,
                ),
                hintText: 'Email',
                errorText: state.email.invalid ? 'Invalid email' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleText(
              text: 'Password',
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: kDefaultPadding / 2),
            TextField(
              key: const Key('signUpForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<SignUpCubit>().passwordChanged(password),
              obscureText: true,
              cursorColor: LightColor.kPrimaryColor,
              decoration: AppTheme.inputDecoration.copyWith(
                prefixIcon: const Icon(
                  Icons.lock,
                  color: LightColor.kPrimaryColor,
                ),
                hintText: 'Password',
                errorText: state.password.invalid ? 'Invalid password' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleText(
              text: 'Confirm Password',
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: kDefaultPadding / 2),
            TextField(
              key: const Key('signUpForm_confirmedPasswordInput_textField'),
              onChanged: (confirmPassword) => context
                  .read<SignUpCubit>()
                  .confirmedPasswordChanged(confirmPassword),
              obscureText: true,
              cursorColor: LightColor.kPrimaryColor,
              decoration: AppTheme.inputDecoration.copyWith(
                prefixIcon: const Icon(
                  Icons.lock,
                  color: LightColor.kPrimaryColor,
                ),
                hintText: 'Confirm password',
                errorText: state.confirmedPassword.invalid
                    ? 'Passwords do not match'
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
                width: double.infinity,
                child: TextButton(
                  key: const Key('signUpForm_continue_Button'),
                  style: AppTheme.textButtonStyle.copyWith(),
                  onPressed: state.status.isValidated
                      ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                      : null,
                  child: const TitleText(
                    text: 'SIGN UP',
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
      },
    );
  }
}
