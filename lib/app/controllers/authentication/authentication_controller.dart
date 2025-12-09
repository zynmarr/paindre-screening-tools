import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:screening_tools_android/app/routes/routes.dart';
import 'package:screening_tools_android/app/utils/utils.dart';

class AuthenticationController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(serverClientId: '1009083053499-s49smndaistusrn9qto75qt0srepckve.apps.googleusercontent.com');
  // final String _customAuthDomain = "10.140.129.201";
  final String _customAuthDomain = "paindre-innovation.com";

  final isLoading = false.obs;

  void _setupAuthDomain() {
    _auth.customAuthDomain = _customAuthDomain;
    // _auth.useAuthEmulator(_customAuthDomain, 9099);
    // _firestore.useFirestoreEmulator(_customAuthDomain, 8080);
    // _firestore.settings = const Settings(persistenceEnabled: false);
  }

  init() {
    _setupAuthDomain();
  }

  Future loginWithEmailAndPassword({required String email, required String password}) async {
    final trace = FirebasePerformance.instance.newTrace('login_with_email');
    trace.start();
    try {
      isLoading.value = true;
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      final doc = await _firestore.collection('features').doc('authentication').get();
      final bool requiresVerification = (doc.data() as Map<String, dynamic>)['email_verification'] ?? false;

      if (user != null && requiresVerification && !user.emailVerified) {
        await _auth.signOut();
        throw FirebaseAuthException(code: 'email-not-verified', message: 'error.message.emailNotVerified'.tr);
      }

      await _updateUserData(user);
      Get.offNamed(Routes.home);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception('error.message.unknown'.tr);
    } finally {
      isLoading.value = false;
      trace.stop();
    }
  }

  Future loginWithGoogle() async {
    final trace = FirebasePerformance.instance.newTrace('login_with_google');
    trace.start();
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // Pengguna membatalkan login

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      await _updateUserData(user); // Update data pengguna di Firestore
      Get.offNamed(Routes.home);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception('error.message.loginWithGoogle'.tr);
    } finally {
      isLoading.value = false;
      trace.stop();
    }
  }

  Future loginWithApple() async {
    final trace = FirebasePerformance.instance.newTrace('login_with_apple');
    trace.start();

    try {
      isLoading.value = true;
      final appleProvider = AppleAuthProvider();
      appleProvider.setCustomParameters({'authDomain': _customAuthDomain});
      final userCredential = kIsWeb ? await _auth.signInWithPopup(appleProvider) : await _auth.signInWithProvider(appleProvider);

      await _updateUserData(userCredential.user); // Update data pengguna di Firestore
      Get.offNamed(Routes.home);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    } finally {
      isLoading.value = false;
      trace.stop();
    }
  }

  Future registerWithEmailAndPassword({required String email, required String password, required String name}) async {
    final trace = FirebasePerformance.instance.newTrace('register_with_email');
    trace.start();
    try {
      isLoading.value = true;

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(name);
        await _updateUserData(user, isNewUser: true);
        await user.sendEmailVerification();
        if (_auth.currentUser!.emailVerified) {
          Get.offNamed(Routes.home);
          Utils.successToast(message: 'success.message.register'.tr);
        }
        await logout();
        Utils.successToast(message: 'success.message.register'.tr);
      }
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception('error.message.register'.tr);
    } finally {
      isLoading.value = false;
      trace.stop();
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      isLoading.value = true;
      await _auth.sendPasswordResetEmail(email: email);

      Get.offAllNamed(Routes.login); // Arahkan kembali ke halaman login
      Utils.successToast(message: 'text.resetPasswordSuccess'.tr);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utils.errorToast(message: 'error.message.userNotFound'.tr);
      } else if (e.code == 'invalid-email') {
        Utils.errorToast(message: 'error.message.invalidEmail'.tr);
      } else {
        Utils.errorToast(message: e.toString());
      }
    } catch (e) {
      Utils.errorToast(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteAccount() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).delete();
        await user.delete();
        await logout();
        Utils.successToast(message: 'success.message.deleteAccount'.tr);
      }
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception('error.message.deleteAccount'.tr);
    }
  }

  Future<void> logout() async {
    Get.offAllNamed(Routes.login);
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<void> _updateUserData(User? user, {bool isNewUser = false}) async {
    if (user == null) return;
    final userRef = _firestore.collection('users').doc(user.uid);
    final userSnapshot = await userRef.get();

    if (isNewUser || !userSnapshot.exists) {
      await userRef.set({
        'uid': user.uid,
        'email': user.email,
        'displayName': user.displayName,
        'photoURL': user.photoURL,
        'role': 'user', // Role default
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }
}
