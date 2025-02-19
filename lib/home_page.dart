import 'dart:developer';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_session_expiry_issue/sign_in_button.dart';
import 'package:aws_session_expiry_issue/sign_out_button.dart';
import 'package:aws_session_expiry_issue/user_details.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);

    return Scaffold(
      body: Center(
        child: FutureBuilder<CognitoAuthSession>(
            future: cognitoPlugin.fetchAuthSession(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                );
              }

              final session = snapshot.data;
              final isSignedIn = session!.isSignedIn;

              final userPoolTokens = session.userPoolTokensResult.valueOrNull;
              final containsIdToken = userPoolTokens?.idToken != null;

              log('${userPoolTokens?.idToken.raw}');

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isSignedIn
                      ? SignOutButton(
                          onSignOut: (_) => setState(() {}),
                        )
                      : SignInButton(
                          onSignIn: (_) => setState(() {}),
                        ),
                  const SizedBox(height: 20),
                  Text(
                    "Id Token Exist? - $containsIdToken",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const UserDetails(),
                ],
              );
            }),
      ),
    );
  }
}
