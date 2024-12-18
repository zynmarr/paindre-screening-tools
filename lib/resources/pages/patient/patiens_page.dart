import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:screening_tools_android/app/controllers/patient/patient.dart';
// import 'package:screening_tools_android/app/core/core.dart';
import 'package:screening_tools_android/app/utils/utils.dart';
import 'package:screening_tools_android/resources/components/components.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cAppBar(
        context,
        title: "Data Pasien",
        centerTitle: true,
        actions: [
          // IconButton(
          //   onPressed: () =>
          //       showSearch(context: context, delegate: CustomSearchDelegate()),
          //   icon: const Icon(Icons.search),
          // )
        ],
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            MdiIcons.chevronLeft,
            size: 20,
          ),
        ),
      ),
      body: Container(
        height: context.height,
        width: context.width,
        decoration: BoxDecoration(
          gradient: cGradient(context),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            log("refresh");
          },
          child: StreamBuilder(
              // padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              stream: PatientController().patients.snapshots(),
              builder: (context, snapshot) {
                // print(snapshot.data!.docs[0].data());
                if (snapshot.hasError) {
                  Utils.paindreShowLoading();
                  Utils.errorToast(message: "Terjadi kesalahan, silahkan coba lagi");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  Utils.paindreShowLoading();
                }

                // return SizedBox.shrink();

                if (snapshot.hasData) {
                  BotToast.closeAllLoading();
                  
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => patientCard(context,
                        patient: Patient.fromMap(snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>)),
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
        ),
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
