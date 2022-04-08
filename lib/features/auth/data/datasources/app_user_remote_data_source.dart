import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/services/crypto.dart';
import 'user_local_data_source.dart';

abstract class AppUserRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<bool> signInWithEmail(String email, String password);
  Future<bool> signInWithGoogle();
  Future<bool> signInWithApple();
  Future<bool> registerWithEmailAndPassword(String email, String password);
  Future<bool> veryifyEmail(String email);
  Future<bool> resetPassword(String email);
  Future<bool> logout();
  Future<bool> isLoggedIn();
  Future<bool> deleteUser();
}

class AppUserRemoteDataSourceImpl implements AppUserRemoteDataSource {
  final AppUserLocalDataSource localDataSource;

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;

  AppUserRemoteDataSourceImpl({
    required this.localDataSource,
    required this.auth,
    required this.firestore,
    required this.googleSignIn,
  });

  @override
  Future<bool> registerWithEmailAndPassword(
      String email, String password) async {
    final UserCredential userCred = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (userCred.user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> resetPassword(String email) async {
    if (auth.currentUser != null) {
      auth.sendPasswordResetEmail(email: email);
      return true;
    } else {
      throw AuthException();
    }
  }

  @override
  Future<bool> logout() async {
    print('Current user is: ${auth.currentUser}');
    if (auth.currentUser != null) {
      Future.wait([
        auth.signOut(),
        googleSignIn.signOut(),
      ]);

      return true;
    } else {
      throw AuthException();
    }
  }

  @override
  Future<bool> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = Crypto.sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    final UserCredential userCred =
        await auth.signInWithCredential(oauthCredential);
    if (userCred.user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> signInWithEmail(String email, String password) async {
    final UserCredential userCred =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    if (userCred.user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleSignInAccount?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential userCred = await auth.signInWithCredential(credential);

    if (userCred.user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> veryifyEmail(String email) async {
    if (auth.currentUser != null) {
      auth.currentUser!.sendEmailVerification();
      return true;
    } else {
      throw AuthException();
    }
  }

  @override
  Future<bool> deleteUser() async {
    //TODO delete user info from backend
    throw ServerException();
  }

  @override
  Future<bool> isLoggedIn() async {
    if (auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
