import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:screening_tools_android/app/controllers/authentication/role_controller.dart';

enum Roles { admin, user, none }

class ServiceController extends ChangeNotifier {
  Roles role = Roles.user; // Using Rx for reactive state
  ConnectivityResult connectivityResult = ConnectivityResult.none; // Reactive variable for connectivity
  RoleController roleController = RoleController(); // Instance of RoleController
  

  ServiceController() {
    _getterRole();
    _connection();
  }

  void _getterRole() {
    FirebaseAuth.instance.userChanges().listen((user) async {
      if (user == null) {
        role = Roles.none; // Update the Rx variable
      } else {
        // Ensure the user exists in Firestore
        await roleController.checkUserAndCreate(); // Check and create user in Firestore if not exists
        // Fetch user role from Firestore or any other source
        role = await roleController.isAdmin() ? Roles.admin : Roles.user; // Update the Rx variable
        // debugPrint('User role: $role');

        // // Get ID token to retrieve custom claims
        // IdTokenResult tokenResult = await user.getIdTokenResult();

        // // Check custom claims
        // if (tokenResult.claims != null && tokenResult.claims!['role'] == 'admin') {
        //   role = Roles.admin; // Update the Rx variable
        // } else {
        //   role = Roles.user; // Update the Rx variable
        // }
      }
      notifyListeners();
    });
  }

  void _connection() {
    Connectivity().onConnectivityChanged.listen((connectivity) {
      connectivityResult = connectivity.first;
      notifyListeners();
    });
  }

  // Optional: Method to change role manually
  // void changeRole(Roles roleName) {
  //   role = roleName; // Update the Rx variable
  //   notifyListeners();
  // }
}
