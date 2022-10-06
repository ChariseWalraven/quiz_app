import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final User? user = FirebaseAuth.instance.currentUser;

  /// Anonymous Firebase login
  Future<void> anonymousLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      // handle error
      debugPrint("ERROR::AuthService:anonymousLogin -> ${e.code} ${e.message}");
    }
  }

  /// Google sign in
  Future<void> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      // handle error
      debugPrint("ERROR::AuthService:googleLogin -> ${e.code} ${e.message}");
    } on PlatformException catch (e) {
      debugPrint(
          "ERROR::AuthService:googleLogin -> ${e.code} ${e.message} ${e.details}");
    } catch (e) {
      debugPrint("ERROR::AuthService:googleLogin -> $e");
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  /// user login
  Future<void> loginUser(String email, String password) async {
    if (email.isEmpty) {
      throw Exception("Email address cannot be empty");
    }
    if (password.isEmpty) {
      throw Exception("Password cannot be empty");
    }

    bool isSuccess = false;
    String errorMessage = "Oops, something went wrong";

    bool userExists = await userWithEmailExists(email);

    try {
      if (userExists) {
        debugPrint("Logging user in: $email");
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        debugPrint("Creating User: $email");
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
      debugPrint("Success! email: ${user?.email} dN: ${user?.displayName}");
      isSuccess = true;
    } on FirebaseAuthException catch (e) {
      debugPrint("ERROR::AuthService:loginUser ${e.code} ${e.message}");
      isSuccess = false;
      errorMessage = e.message ?? errorMessage;
    } catch (e) {
      debugPrint("ERROR::AuthService:loginUser $e");
      isSuccess = false;
      errorMessage = e.toString();
    }
    if (!isSuccess) {
      throw Exception(errorMessage);
    }
  }

  Future<bool> isLoggedIn() async {
    throw UnimplementedError();
  }

  Future<bool> userWithEmailExists(String email) async {
    bool userExists = false;
    try {
      List<String> userSignInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      debugPrint("Sign in methods for user: ${userSignInMethods.toString()}");
      debugPrint("User exists: ${userSignInMethods.isNotEmpty}");
      userExists = userSignInMethods.isNotEmpty;
    } on Exception catch (e) {
      debugPrint("Whoops. Something went wrong. $e");
    }

    return userExists;
  }

  Future<List<String>> getUserSignInMethods() async {
    String email = user?.email ?? "";
    if (email.isNotEmpty) {
      var result =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      debugPrint(result.toString());
      return result;
    } else {
      throw Exception("Sign in methods could not be retreived.");
    }
  }

  void updateProfilePic(String photoURL) async {
    await user?.updatePhotoURL(photoURL);
  }
}
