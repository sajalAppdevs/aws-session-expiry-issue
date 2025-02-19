import 'dart:developer';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'amplify_config.dart';

class AmplifyService {
  static bool get isConfigured => Amplify.isConfigured;

  static Future init() async {
    await Amplify.addPlugins([AmplifyAuthCognito()]);

    try {
      await Amplify.configure(amplifyConfig);
    } on AmplifyAlreadyConfiguredException {
      log('Amplify was already configured. Was the app restarted?');
      return null;
    }
  }

  static Future<String?> getIdToken() async {
    try {
      final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
      final session = await cognitoPlugin.fetchAuthSession();

      final userPoolTokens = session.userPoolTokensResult.valueOrNull;

      if (userPoolTokens == null) {
        log('❌ [AmplifyService] userPoolTokens is null ❌');
        return null;
      }

      return userPoolTokens.idToken.raw;
    } on Exception catch (e) {
      log('❌ [AmplifyService] Error getting idToken: $e ❌');
      return null;
    }
  }

  static String get amplifyConfig {
    const String authenticationFlowType = Config.authenticationFlowType;
    const String poolId = Config.poolId;
    const String appClientId = Config.appClientId;
    const String region = Config.region;

    return ''' {
      "UserAgent": "aws-amplify-cli/2.0",
      "Version": "1.0",
      "auth": {
        "plugins": {
          "awsCognitoAuthPlugin": {
            "UserAgent": "aws-amplify-cli/0.1.0",
            "Version": "0.1.0",
            "IdentityManager": {
              "Default": {}
            },
            "CognitoUserPool": {
              "Default": {
                "PoolId": "$poolId",
                "AppClientId": "$appClientId",
                "Region": "$region"
              }
            },
            "Auth": {
              "Default": {
                "authenticationFlowType": "$authenticationFlowType"
              }
            }
          }
        }
      }
    } ''';
  }
}
