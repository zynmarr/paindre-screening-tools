// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:screening_tools_android/app/controllers/patient/patient.dart';
import 'package:screening_tools_android/resources/components/components.dart';

class PatientArguments {
  final bool isHistory;
  PatientArguments({required this.isHistory});
}

class PatientPage extends StatefulWidget {
  final bool isHistory;
  const PatientPage({super.key, required this.isHistory});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cAppBar(
        title: widget.isHistory ? 'screeningData'.tr : 'patientData'.tr,
        centerTitle: true,
        leading: GestureDetector(onTap: () => Get.back(), child: Icon(MdiIcons.chevronLeft, size: 20)),
      ),
      body: Stack(
        children: [
          Positioned(
            left: -1,
            right: -2,
            bottom: 0,
            child: CustomPaint(size: Size(context.width, context.height / 1.9), painter: RPSCustomPainter1()),
          ),
          Positioned(
            left: -2,
            right: -2,
            bottom: -2,
            child: CustomPaint(size: Size(context.width, context.height / 2.0), painter: RPSCustomPainter2()),
          ),
          SizedBox(
            height: context.height,
            width: context.width,
            child: StreamBuilder<QuerySnapshot>(
              stream: widget.isHistory ? PatientController().patients.where('user_id', isEqualTo: user!.uid).snapshots() : PatientController().patients.orderBy('created_at').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Terjadi kesalahan, silahkan coba lagi",
                      style: context.textTheme.bodyLarge!.copyWith(color: Colors.blue[900], fontWeight: FontWeight.bold),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) return Center(child: cLoading());
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text(
                    "Belum ada data pemeriksaan",
                    style: context.textTheme.bodyLarge!.copyWith(color: Colors.blue[900], fontWeight: FontWeight.bold),
                  );
                }

                // Data tersedia, tampilkan ListView
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> patientData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                    patientData['user_id'] = patientData['user_id'] ?? '';
                    patientData['diagnostic'] = patientData['diagnostic'] ?? 'Kosong';

                    return patientCard(context, patient: Patient.fromMap(patientData));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class CustomSearchDelegate extends SearchDelegate {
//   static List getData = GetStorage().read('patients') ?? [];

//   List<Patient> name = List.generate(
//       getData.length, (index) => Patient.fromJson(getData[index]));

//   Widget build(BuildContext context) {
//     return const Scaffold();
//   }

//   @override
//   ThemeData appBarTheme(BuildContext context) {
//     return AppTheme()
//         .themeData
//         .copyWith(inputDecorationTheme: searchFieldDecorationTheme);
//   }

//   @override
//   TextStyle? get searchFieldStyle => const TextStyle(
//         color: Colors.white,
//         fontSize: 20,
//         decoration: TextDecoration.none,
//       );

//   @override
//   InputDecorationTheme? get searchFieldDecorationTheme =>
//       const InputDecorationTheme(
//         labelStyle: TextStyle(
//           color: Colors.white,
//         ),
//         helperStyle: TextStyle(color: Colors.white),
//         hintStyle: TextStyle(
//           color: Colors.white,
//         ),
//         border: InputBorder.none,
//       );

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//           showSuggestions(context);
//         },
//         icon: const Icon(Icons.clear),
//       ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: const Icon(Icons.arrow_back_ios),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     List<Patient> macthQuery = [];
//     for (var data in name) {
//       if (data.name.toLowerCase().contains(query.toLowerCase()) ||
//           data.name.toLowerCase().startsWith(query.toLowerCase()) ||
//           data.id.toString().toLowerCase().startsWith(query.toLowerCase())) {
//         macthQuery.add(data);
//       }
//     }
//     return Container(
//       height: context.height,
//       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//       child: macthQuery.isNotEmpty
//           ? ListView.builder(
//               itemCount: macthQuery.length,
//               itemBuilder: (context, index) {
//                 var result = macthQuery[index];
//                 return patientCard(context, patient: result);
//               },
//             )
//           : Column(
//               children: [
//                 textCard(context: context, title: "Data tidak ditemukan"),
//               ],
//             ),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<Patient> macthQuery = [];
//     for (var data in name) {
//       if (data.name.toLowerCase().contains(query.toLowerCase()) ||
//           data.name.toLowerCase().startsWith(query.toLowerCase()) ||
//           data.id.toString().toLowerCase().startsWith(query.toLowerCase())) {
//         macthQuery.add(data);
//       }
//     }
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//       child: ListView.builder(
//         itemCount: macthQuery.length,
//         itemBuilder: (context, index) {
//           var result = macthQuery[index];
//           return GestureDetector(
//             onTap: () {
//               log("$result");
//               showResults(context);
//               query = query.isNum
//                   ? result.id.toString()
//                   : query.isAlphabetOnly
//                       ? result.name
//                       : result.name;
//             },
//             child: Card(
//               elevation: 1,
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
//                 child: Text(
//                   query.isNum
//                       ? result.id.toString()
//                       : query.isAlphabetOnly
//                           ? result.name
//                           : result.name,
//                   style: const TextStyle(fontSize: 18),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
