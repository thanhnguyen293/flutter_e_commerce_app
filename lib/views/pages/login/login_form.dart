import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';

import '../../../themes/theme.dart';
import '../../../views/widgets/title_text.dart';
import '../../../cubit/login/login_cubit.dart';
import '../../../cubit/login/login_state.dart';
import '../../../themes/light_color.dart';
import '../sign_up/sign_up_page.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
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
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.28,
                  child: Image.asset('assets/images/login.png'),
                ),
              ),
            ),
            DraggableScrollableSheet(
              maxChildSize: 0.9,
              initialChildSize: 0.7,
              minChildSize: 0.7,
              builder: (ctx, scrollController) {
                return Container(
                  //height: MediaQuery.of(context).size.height * 0.8,
                  decoration: const BoxDecoration(
                      color: LightColor.bgColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      )),
                  child: SingleChildScrollView(
                    //physics: NeverScrollableScrollPhysics(),
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 30),
                          const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'SF Pro',
                            ),
                          ),
                          const SizedBox(height: 32),
                          _EmailInput(),
                          const SizedBox(height: 32),
                          _PasswordInput(),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {},
                              child: const TitleText(
                                text: 'Need help?',
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0x99200A4D),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _LoginButton(),
                          const SizedBox(height: 32),
                          const TitleText(
                            text: 'Or Login With',
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: Color(0x99200A4D),
                          ),
                          const SizedBox(height: 28),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              _GoogleLoginButton(),
                              SizedBox(width: 24),
                              _FacebookLoginButton(),
                              SizedBox(width: 24),
                              _AppleLoginButton()
                            ],
                          ),
                          const SizedBox(height: 28),
                          _SignUpButton(),
                          const SizedBox(height: 39)
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

class _AppleLoginButton extends StatelessWidget {
  const _AppleLoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SocialIconButton(
      icon: SvgPicture.asset('assets/icons/apple.svg'),
      press: () {},
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleText(
              text: 'Email',
              color: Color(0xFF200A4D),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
            TextField(
                key: const Key('loginForm_emailInput_textField'),
                onChanged: (email) =>
                    context.read<LoginCubit>().emailChanged(email),
                keyboardType: TextInputType.emailAddress,
                cursorColor: LightColor.kPrimaryColor,
                decoration: AppTheme.inputDecoration.copyWith(
                  //labelText: 'Email',
                  // prefixIcon: const Icon(
                  //   Icons.email,
                  //   color: LightColor.kPrimaryColor,
                  // ),
                  suffixIcon: SizedBox(
                    height: 15,
                    width: 15,
                    child: state.email.pure
                        ? SizedBox()
                        : SvgPicture.asset(
                            state.email.invalid
                                ? 'assets/icons/verification_error_icon.svg'
                                : 'assets/icons/verified_icon.svg',
                            fit: BoxFit.scaleDown,
                            height: 14,
                            width: 14,
                          ),
                  ),
                  hintText: 'Email',
                  errorText: state.email.invalid ? 'invalid email' : null,
                  //suffixIcon: Icon(Icons.verified_rounded),
                )),
          ],
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          (previous.password != current.password) ||
          (previous.passwordHide != current.passwordHide),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleText(
              text: 'Password',
              color: Color(0xFF200A4D),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
            TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<LoginCubit>().passwordChanged(password),
              obscureText: state.passwordHide,
              cursorColor: LightColor.kPrimaryColor,
              decoration: AppTheme.inputDecoration.copyWith(
                // prefixIcon: const Icon(
                //   Icons.lock,
                //   color: LightColor.kPrimaryColor,
                // ),
                suffixIcon: InkWell(
                  onTap: () {
                    context
                        .read<LoginCubit>()
                        .passwordHide(!state.passwordHide);
                  },
                  // child: Icon(state.passwordHide
                  //     ? Icons.remove_red_eye
                  //     : Icons.remove_red_eye_outlined),
                  child: SvgPicture.asset(
                    state.passwordHide
                        ? 'assets/icons/eye.svg'
                        : 'assets/icons/eye_off.svg',
                    height: 15,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                hintText: 'Password',
                errorText: state.password.invalid ? 'invalid password' : null,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_materialButton'),
                onPressed: state.status.isValidated
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
                //style: AppTheme.textButtonStyle,
                // style: TextButton.styleFrom(
                //   backgroundColor: Colors.red,

                // ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  height: 68,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        colors: [Color(0xFFE65828), Color(0xFFF59676)]),
                  ),
                  child: const TitleText(
                    text: 'LOGIN',
                    fontSize: 17,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  const _GoogleLoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return SocialIconButton(
      press: () => context.read<LoginCubit>().logInWithGoogle(),
      icon: SvgPicture.asset('assets/icons/google.svg'),
    );
    // return ElevatedButton.icon(
    //   key: const Key('loginForm_googleLogin_raisedButton'),
    //   label: const Text(
    //     'LOGIN WITH GOOGLE',
    //     style: TextStyle(color: Colors.white),
    //   ),
    //   style: ElevatedButton.styleFrom(
    //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(kDefaultRadius / 2),
    //     ),
    //     primary: theme.colorScheme.secondary,
    //   ),
    //   icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
    //   onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
    // );
  }
}

class _FacebookLoginButton extends StatelessWidget {
  const _FacebookLoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SocialIconButton(
      icon: SvgPicture.asset('assets/icons/facebook.svg'),
      press: () {},
    );
  }
}

class SocialIconButton extends StatelessWidget {
  const SocialIconButton({
    required this.press,
    required this.icon,
    Key? key,
  }) : super(key: key);
  final VoidCallback press;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        height: 64,
        width: 64,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            width: 1,
            color: const Color(0x33200A4D),
          ),
        ),
        child: icon,
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TitleText(
          text: 'Newbie? ',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          // /style: TextStyle(color: theme.primaryColor),
        ),
        InkWell(
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(SignUpPage.routeName),
          child: const TitleText(
            text: 'Create Account',
            color: LightColor.kPrimaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
