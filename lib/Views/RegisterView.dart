// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mynotes/constants/routes.dart';
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
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email,
                password: password,
              );
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                await showErrorDialog(
                  context,
                  'Weak password',
                );
              } else if (e.code == 'email-already-in-use') {
                await showErrorDialog(
                  context,
                  'Email is already in use',
                );
              } else if (e.code == 'unvalid-email') {
                await showErrorDialog(
                  context,
                  'Invalid email',
                );
              } else {
                await showErrorDialog(
                  context,
                  'Error: ${e.code}',
                );
              }
            } catch (e) {
              await showErrorDialog(
                context,
                e.toString(),
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
