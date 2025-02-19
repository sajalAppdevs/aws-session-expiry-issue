import 'dart:developer';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_session_expiry_issue/home_page.dart';
import 'package:flutter/material.dart';

import 'amplify_logger.dart';
import 'amplify_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AmplifyService.init();

  AmplifyLogger().logLevel = LogLevel.verbose;
  AmplifyLogger().registerPlugin(AppAmplifyLogger());

  Amplify.Hub.listen(HubChannel.Auth, (event) {
    log('Amplify.Hub.listen: $event');
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AWS Session Experiment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
