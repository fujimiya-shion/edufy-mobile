import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {

  GoogleAuthService._();

  static bool _isInitialized = false;

  static Future<void> initialize() async {
    final clientId = Platform.isIOS 
      ? const String.fromEnvironment("GOOGLE_SIGNIN_IOS_CLIENT_ID")
      : const String.fromEnvironment("GOOGLE_SIGNIN_ANDROID_CLIENT_ID");

    const serverClientId = String.fromEnvironment("GOOGLE_SIGNIN_SERVER_CLIENT_ID");
    await GoogleSignIn.instance.initialize(
      clientId: clientId,
      serverClientId: serverClientId,
    );

    _isInitialized = true;
  }

  static Future<void> initializeIfNeeded() async {
    if (!_isInitialized) {
      await initialize();
      _isInitialized = true;
    }
  }

  /// Sign in and get server auth code
  /// If the system have own server
  static Future<String?> signInAndGetServerAuthCode() async {
    await GoogleAuthService.initializeIfNeeded();

    try {
      final signInAccount = await GoogleSignIn.instance.authenticate(
        scopeHint: const ['email', 'profile', 'openid'],
      );

      return signInAccount.authentication.idToken;
    }
    catch(e) {
      print(e);
      return null;
    }
  }

  static Future<void> signOut() async {
    await GoogleSignIn.instance.disconnect();
  }
}