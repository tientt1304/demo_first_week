import 'package:demo_first_week/business_logic/blocs/form/form_bloc.dart';
import 'package:demo_first_week/helper/constants.dart';
import 'package:demo_first_week/presentation/pages/home/home_page.dart';
import 'package:demo_first_week/presentation/pages/sign_in/sign_in_page.dart';
import 'package:demo_first_week/presentation/widgets/main_button.dart';
import 'package:demo_first_week/presentation/widgets/title_content.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static String routeName = '/SignUpPage';
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _repasswordFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<FormBloC>().add(EmailUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<FormBloC>().add(PasswordUnfocused());
      }
    });
    _repasswordFocusNode.addListener(() {
      if(!_repasswordFocusNode.hasFocus){
        context.read<FormBloC>().add(RepasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _repasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => FormBloC(),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const TitleContent(
                    title: 'Sign Up',
                    content: 'Sign up with email and password',
                  ),
                  BlocListener<FormBloC, DemoFormState>(
                    listener: (context, state) {
                      if (state.status.isSubmissionSuccess) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomePage.routeName, (route) => false);
                      }
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            EmailInput(focusNode: _emailFocusNode),
                            const SizedBox(
                              height: 20,
                            ),
                            PasswordInput(
                              focusNode: _passwordFocusNode,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RepasswordInput(
                              focusNode: _repasswordFocusNode,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SubmitButton()
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have account. ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.popAndPushNamed(
                              context, SignInPage.routeName);
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 16,
                              color: mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  const SizedBox (height: 20,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloC, DemoFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return MainButton(
            onTap: state.status.isValidated
                ? () => context.read<FormBloC>().add(FormSubmitted())
                : () {},
            title: "Sign Up");
      },
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key, required this.focusNode}) : super(key: key);
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloC, DemoFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email.value,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: 'Enter your email',
            labelText: 'Email',
            helperText: 'A complete, valid email e.g. tientt@gmail.com',
            errorText: state.email.invalid
                ? 'Please ensure the email entered is valid'
                : null,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            context.read<FormBloC>().add(EmailChanged(email: value));
          },
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key, required this.focusNode}) : super(key: key);
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloC, DemoFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            labelText: 'Password',
            helperText:
                '''Password should be at least 8 characters with at least one letter and number''',
            helperMaxLines: 2,
            errorMaxLines: 2,
            errorText: state.password.invalid
                ? 'Please ensure the email entered is valid'
                : null,
          ),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          onChanged: (value) {
            context.read<FormBloC>().add(PasswordChanged(password: value));
          },
        );
      },
    );
  }
}

class RepasswordInput extends StatelessWidget {
  const RepasswordInput({Key? key, required this.focusNode}) : super(key: key);
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloC, DemoFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: 'Re-enter your password',
            labelText: 'Re-password',
            helperText:
                '''Re-password has to match with password''',
            helperMaxLines: 2,
            errorMaxLines: 2,
            errorText: state.password.invalid
                ? 'Please ensure the email entered is valid'
                : null,
          ),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          onChanged: (value) {
            context.read<FormBloC>().add(PasswordChanged(password: value));
          },
        );
      },
    );
  }
}
