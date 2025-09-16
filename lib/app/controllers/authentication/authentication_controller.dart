import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference feature = FirebaseFirestore.instance.collection('features');

  final GoogleSignIn googleSignIn = GoogleSignIn(
    // Optionally specify scopes if needed
    scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly'],
    // You can specify signInOption if needed; default is standard
    signInOption: SignInOption.standard,
    serverClientId: '1009083053499-s49smndaistusrn9qto75qt0srepckve.apps.googleusercontent.com',
  );

  Future<UserCredential> loginWithApple() async {
    final appleProvider = AppleAuthProvider();
    return await FirebaseAuth.instance.signInWithProvider(appleProvider);
  }

  Future<User?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null; // Jika user batal login

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        return user;
      }
      return null;
    } catch (e) {
      return Future.error('error.message.loginWithGoogle'.tr + e.toString());
    }
  }

  Future<User?> loginWithEmailAndPassword({required String email, required String password}) async {
    try {
      Map<String, dynamic> data = await feature.doc('authentication').get().then((value) => value.data() as Map<String, dynamic>);
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      // Memeriksa apakah user null
      if (user == null) {
        return Future.error('error.message.whenLogin'.tr);
      }

      // Memeriksa apakah email sudah diverifikasi
      if (data['email_verification'] == true) {
        if (!user.emailVerified) {
          return Future.error('error.message.emailNotVerified'.tr);
        }
      }

      return user; // Mengembalikan user jika login berhasil
    } on FirebaseAuthException catch (error) {
      // debugPrint(error.toString());
      // Menangani kesalahan spesifik dari Firebase
      if (error.code == 'user-not-found') {
        return Future.error('error.message.userNotFound'.tr);
      } else if (error.code == 'wrong-password') {
        return Future.error('error.message.wrongPassword'.tr);
      } else if (error.code == 'invalid-email') {
        return Future.error('error.message.invalidEmail'.tr);
      } else if (error.code == 'invalid-credential') {
        return Future.error('error.message.invalidCredential'.tr);
      } else {
        return Future.error('error.message.login'.tr + error.message.toString());
      }
    }
  }

  Future<User?> registerWithEmailAndPassword({required String email, required String password, required String name}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user?.updateDisplayName(name);
      User? user = userCredential.user;
      await user?.sendEmailVerification();

      if (user != null) {
        return user;
      }
      return Future.error('error.message.whenRegister'.tr);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        return Future.error('error.message.emailAlreadyInUse'.tr);
      } else {
        return Future.error('error.message.register'.tr + error.message.toString());
      }
    }
  }

  // Future<void> checkUserRole() async {
  //   User? user = FirebaseAuth.instance.currentUser;

  //   if (user != null) {
  //     // create a user document if it doesn't exist
  //     DocumentReference userDoc = userCollection.doc(user.uid);
  //     DocumentSnapshot userSnapshot = await userDoc.get();
  //     if (!userSnapshot.exists) {
  //       await userDoc.set({
  //         'uid': user.uid,
  //         'email': user.email,
  //         'displayName': user.displayName,
  //         'photoURL': user.photoURL,
  //         'role': 'user', // Default role
  //       });
  //     } else {

  //     }

  //     // Ambil token ID untuk mendapatkan custom claims
  //     IdTokenResult tokenResult = await user.getIdTokenResult();

  //     // Periksa custom claims
  //     if (tokenResult.claims != null && tokenResult.claims!['role'] == 'admin') {
  //       debugPrint('User is an admin');
  //       debugPrint(tokenResult.toString());
  //       // Lakukan sesuatu untuk admin
  //     } else {
  //       debugPrint(tokenResult.toString());
  //       debugPrint('User is not an admin');
  //       // Lakukan sesuatu untuk pengguna biasa
  //     }
  //   }
  // }
}
