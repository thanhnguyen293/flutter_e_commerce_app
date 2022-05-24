import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_e_commerce_app/views/pages/login/login_page.dart';
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
        decoration: const BoxDecoration(
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
            DraggableScrollableSheet(
              initialChildSize: 0.7,
              minChildSize: 0.7,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: LightColor.bgColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'SF Pro',
                            ),
                          ),
                          const SizedBox(height: 24),
                          _UserNameInput(),
                          const SizedBox(height: kDefaultPadding),
                          _EmailInput(),
                          const SizedBox(height: kDefaultPadding),
                          _PasswordInput(),
                          const SizedBox(height: kDefaultPadding),
                          _ConfirmPasswordInput(),
                          const SizedBox(height: 17),
                          const _TermAndServices(),
                          const SizedBox(height: 14),
                          _SignUpButton(),
                          const SizedBox(height: 22),
                          const _LoginButton(),
                          const SizedBox(height: 29),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TitleText(
          text: 'Existing User? ',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
          },
          child: const TitleText(
            text: 'Log In',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: LightColor.kPrimaryColor,
          ),
        )
      ],
    );
  }
}

class _TermAndServices extends StatelessWidget {
  const _TermAndServices({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          const TitleText(
            text: 'Yes, I agree to the ',
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          InkWell(
              onTap: () {},
              child: const Text(
                'Terms & Services.',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              )),
        ],
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
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
              const SizedBox(height: kDefaultPadding / 2),
              TextField(
                key: const Key('signUpForm_FullNameInput_textField'),
                onChanged: (userName) =>
                    context.read<SignUpCubit>().userNameChanged(userName),
                //keyboardType: TextInputType.emailAddress,
                cursorColor: LightColor.kPrimaryColor,
                decoration: AppTheme.inputDecoration.copyWith(
                  hintText: 'Full Name',
                  errorText: state.username.invalid ? 'Invalid username' : null,
                  suffixIcon: state.username.pure
                      ? const SizedBox()
                      : SvgPicture.asset(
                          state.username.invalid
                              ? 'assets/icons/verification_error_icon.svg'
                              : 'assets/icons/verified_icon.svg',
                          fit: BoxFit.scaleDown,
                          height: 14 ,
                          width: 14,
                        ),
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
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
            const SizedBox(height: kDefaultPadding / 2),
            TextField(
              key: const Key('signUpForm_emailInput_textField'),
              onChanged: (email) =>
                  context.read<SignUpCubit>().emailChanged(email),
              keyboardType: TextInputType.emailAddress,
              cursorColor: LightColor.kPrimaryColor,
              decoration: AppTheme.inputDecoration.copyWith(
                hintText: 'Email',
                suffixIcon: state.email.pure
                    ? const SizedBox()
                    : SvgPicture.asset(
                        state.email.invalid
                            ? 'assets/icons/verification_error_icon.svg'
                            : 'assets/icons/verified_icon.svg',
                        fit: BoxFit.scaleDown,
                        height: 14,
                        width: 14,
                      ),
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
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
            const SizedBox(height: kDefaultPadding / 2),
            TextField(
              key: const Key('signUpForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<SignUpCubit>().passwordChanged(password),
              obscureText: true,
              cursorColor: LightColor.kPrimaryColor,
              decoration: AppTheme.inputDecoration.copyWith(
                hintText: 'Password',
                errorText: state.password.invalid ? 'Invalid password' : null,
                suffixIcon: state.password.pure
                    ? const SizedBox()
                    : SvgPicture.asset(
                        state.password.invalid
                            ? 'assets/icons/verification_error_icon.svg'
                            : 'assets/icons/verified_icon.svg',
                        fit: BoxFit.scaleDown,
                        height: 14,
                        width: 14,
                      ),
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
              fontWeight: FontWeight.w400,
              fontSize: 13,
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
                hintText: 'Confirm password',
                errorText: state.confirmedPassword.invalid
                    ? 'Passwords do not match'
                    : null,
                suffixIcon: state.confirmedPassword.pure
                    ? const SizedBox()
                    : SvgPicture.asset(
                        state.confirmedPassword.invalid
                            ? 'assets/icons/verification_error_icon.svg'
                            : 'assets/icons/verified_icon.svg',
                        fit: BoxFit.scaleDown,
                        height: 14,
                        width: 14,
                      ),
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
            : ElevatedButton(
                key: const Key('signUpForm_continue_Button'),
                // style: AppTheme.textButtonStyle.copyWith(),
                onPressed: state.status.isValidated
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Container(
                  height: 68,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        colors: [Color(0xFFE65828), Color(0xFFF59676)]),
                  ),
                  child: const Center(
                    child: TitleText(
                      text: 'SIGN UP',
                      color: Color(0xFFFFFFFF),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              );
      },
    );
  }
}
