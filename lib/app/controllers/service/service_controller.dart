import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:screening_tools_android/app/routes/routes.dart';
import 'package:screening_tools_android/resources/pages/error/error_page.dart';

enum Roles { admin, user }

class ServiceController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  Roles role = Roles.user; // Default role
  String? versionApp;
  bool isChecking = false;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  late StreamSubscription<User?> _authStateSubscription; // Subscription untuk status auth

  ServiceController() {
    _initialize();
  }

  void _initialize() {
    _getAppVersion();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
    _authStateSubscription = _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? user) async {
    if (user != null) {
      try {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists && doc.data()?['role'] == 'admin') {
          role = Roles.admin;
        } else {
          role = Roles.user;
        }
      } catch (e) {
        role = Roles.user;
      }
    } else {
      role = Roles.user;
    }
    notifyListeners();
  }

  Future<void> _getAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      versionApp = packageInfo.version;
      notifyListeners();
    } catch (e) {
      versionApp = null;
      notifyListeners();
    }
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    if (result.contains(ConnectivityResult.none) && !result.contains(ConnectivityResult.wifi) && !result.contains(ConnectivityResult.mobile)) {
      connectivityResult = ConnectivityResult.none;
      Get.offAllNamed(Routes.error, arguments: ErrorArguments(message: 'Service Unavailable', code: 503));
    } else {
      connectivityResult = result.firstWhere((r) => r != ConnectivityResult.none, orElse: () => ConnectivityResult.none);
    }
    notifyListeners();
  }

  void checkAppStatus(Map<String, dynamic> option) {
    if (isChecking) return;
    isChecking = true;

    Future.delayed(Duration(milliseconds: 100), () {
      if (option['maintanance_mode'] == true) {
        Get.offAllNamed(Routes.maintanance);
      } else if (option['is_required_update'] == true && option['version'] != versionApp) {
        Get.offAllNamed(Routes.requestUpdate);
      }
      isChecking = false;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _authStateSubscription.cancel();
    super.dispose();
  }
}
