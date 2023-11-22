// ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';

import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exeptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register '),
      ),
      body: Column(children: [
        TextField(
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(hintText: 'Enter your Email here'),
        ),
        TextField(
          controller: _password,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration:
              const InputDecoration(hintText: 'Enter your Password here'),
        ),
        TextButton(
          child: const Text('Register'),
          onPressed: () async {
            final email = _email.text;
            final password = _password.text;
            try {
              await AuthService.firebase().createUser(
                email: email,
                password: password,
              );
              AuthService.firebase().sendEmailVerification();
            } on WeakPasswordAuthExeption{
              await showErrorDialog(
                  context,
                  'Weak password',
                );
            } on EmailAlreadyInUseAuthExeption{
              await showErrorDialog(
                  context,
                  'Email is already in use',
                );
            } on InvalidEmailAuthExeption{
              await showErrorDialog(
                  context,
                  'Invalid email',
                );
            }on GenericAuthExeption{
              await showErrorDialog(
                  context,
                  'Failed to register',
                );
            }
            // other sign in methods (Google): https://firebase.flutter.dev/docs/auth/usage/#other-sign-in-methods
          },
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(loginRoute, (route) => false);
          },
          child: const Text('Registered? Log in here!'),
        )
      ]),
    );
  }
}
