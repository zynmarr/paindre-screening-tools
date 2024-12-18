import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:screening_tools_android/app/controllers/scoring_result/scoring_result.dart';
import 'package:screening_tools_android/resources/components/components.dart';

class PainResultPage extends StatefulWidget {
  const PainResultPage({super.key});

  @override
  State<PainResultPage> createState() => _PainResultPageState();
}

class _PainResultPageState extends State<PainResultPage> {
  String idPatient = Get.arguments['id_patient'];
  // List<ScoringResult> listScoringResult = [];

  String textResult = "Hasil semua pemeriksaan anda menderita:";
  String textResult2 = "Tidak ditemukan nyeri specifik, mohon lakukan pemeriksaan ulang kembali.";

  @override
  Widget build(BuildContext context) {
    double gWidth = context.width / 2.2;

    return WillPopScope(
      onWillPop: () async {
        final dialog = cDialog(
          context,
          title: "Pemberitahuan",
          middleText: "Apakah anda yakin ingin keluar dari halaman ini?",
          onSucces: () => Get.offAllNamed('home-page'),
          onCancel: () => Get.back(),
        );

        return dialog;
      },
      child: Scaffold(
        appBar: cAppBar(context, title: 'Hasil Pemeriksaan Akhir', centerTitle: true),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [
              Container(
                height: gWidth / 1.2,
                width: gWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset('assets/images/screening-logo.png'),
              ),
              const SizedBox(height: 25),
              Container(
                width: context.width,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    StreamBuilder(
                      stream: ScoringResultController().scoringResults.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<ScoringResult> item = snapshot.data!.docs
                              .where((p) => p['id_patient'] == idPatient)
                              .map(
                                (p) => ScoringResult.fromMap(p.data() as Map<String, dynamic>),
                              )
                              .toList();

                          print(item.length);

                          if (item.isNotEmpty) {
                            return Column(
                              children: [
                                Text(
                                  textResult,
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 20),
                                for (ScoringResult p in item)
                                  Row(
                                    children: [
                                      Icon(MdiIcons.minus, size: 25),
                                      Text(
                                        p.type,
                                        style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 8),
                              ],
                            );
                          } else {
                            return Text(
                              textResult2,
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                            );
                          }
                        } else {
                          return Text(
                            "Data tidak ditemukan, terjadi kesalahan pada server",
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: context.width / 3,
                child: ElevatedButton(
                  onPressed: () async => Get.offAllNamed('home-page'),
                  child: Text(
                    'Keluar',
                    style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
