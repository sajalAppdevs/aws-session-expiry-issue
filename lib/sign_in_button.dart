import 'dart:developer';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key, this.onSignIn});

  final ValueChanged<SignInResult?>? onSignIn;

  Future<void> _signIn() async {
    try {
      final result = await Amplify.Auth.signIn(
        password: "Alvish@1212",
        username: "alvish.emulator+5@gmail.com",
        options: const SignInOptions(
          pluginOptions: CognitoSignInPluginOptions(
            authFlowType: AuthenticationFlowType.userPasswordAuth,
          ),
        ),
      );

      onSignIn?.call(result);

      log('✅ [SignInButton] Signed in ✅');
    } catch (e) {
      onSignIn?.call(null);

      log('❌ [SignInButton] Error signing in: $e ❌');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _signIn,
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
      ),
      child: const Text(
        'Sign In',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
