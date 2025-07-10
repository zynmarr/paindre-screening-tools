// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:firebase_app_check/firebase_app_check.dart';

// class ApiService {
//   Future verifyToken(String url) async {
//     // Ambil token App Check
//     // String? appCheckToken = await FirebaseAppCheck.instance.getToken();

//     // Buat header dengan token
//     Map<String, String> headers = {'X-Firebase-AppCheck': appCheckToken ?? ''};

//     // Lakukan permintaan GET
//     final response = await http.post(Uri.parse(url), headers: headers);

//     // Periksa status respons
//     if (response.statusCode == 200) {
//       debugPrint("SUCCESS RESPONSE: ${response.body}");
//       // return response;
//     } else {
//       debugPrint("ERROR RESPONSE: ${response.body}");
//       // throw Exception('Failed to load data');
//     }
//   }
// }
