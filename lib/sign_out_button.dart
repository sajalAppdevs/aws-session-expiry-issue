import 'dart:developer';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key, this.onSignOut});

  final ValueChanged<SignOutResult?>? onSignOut;

  Future<void> _signOut() async {
    try {
      final result = await Amplify.Auth.signOut();

      onSignOut?.call(result);

      log('✅ [SignOutButton] Signed out ✅');
    } catch (e) {
      onSignOut?.call(null);

      log('❌ [SignOutButton] Error signing out: $e ❌');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _signOut,
      style: TextButton.styleFrom(
        backgroundColor: Colors.red,
      ),
      child: const Text(
        "Sign Out",
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
