import 'dart:developer';

import 'package:amplify_flutter/amplify_flutter.dart';

class AppAmplifyLogger implements AWSLoggerPlugin {
  @override
  void handleLogEntry(LogEntry entry) {
    log('[TowtaledyAmplifyLogger] Message: ${entry.message}, Error: ${entry.error}');
  }
}
