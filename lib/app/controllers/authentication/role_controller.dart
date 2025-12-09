import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RoleController {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference<Map<String, dynamic>> userCollection = FirebaseFirestore.instance.collection('users');
  Future<void> checkUserAndCreate() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final userData = await userCollection.doc(user.uid).get();
    if (!userData.exists) {
      await userCollection.doc(user.uid).set({
        'email': user.email,
        'displayName': user.displayName,
        'photoURL': user.photoURL,
        'role': 'user', // Default role
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<bool> isAdmin() async {
    final user = _auth.currentUser;
    if (user == null) return false;

    final userData = await userCollection.doc(user.uid).get();
    if (!userData.exists) return false;

    final data = userData.data();
    if (data == null || data['role'] == null) return false;

    return data['role'] == 'admin';
  }

  Future<bool> isUser() async {
    final user = _auth.currentUser;
    if (user == null) return false;

    final userData = await userCollection.doc(user.uid).get();
    if (!userData.exists) return false;

    final data = userData.data();
    if (data == null || data['role'] == null) return false;

    return data['role'] == 'user';
  }
}
