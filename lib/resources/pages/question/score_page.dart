import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screening_tools_android/app/controllers/scoring_result/scoring_result.dart';
import 'package:screening_tools_android/app/utils/utils.dart';
import 'package:screening_tools_android/resources/components/components.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  String idPatient = Get.arguments['id_patient'];
  int sbjScore = Get.arguments['sbj_score'];
  int peScore = Get.arguments['pe_score'];
  String questioName = Get.arguments['name'];

  String textResult = '';

  genereteResult() async {
    if (questioName == 'Nyeri Nosiseptif') {
      if (sbjScore >= 5 && peScore >= 1) {
        ScoringResult data = ScoringResult(id: "1", type: questioName, value: (sbjScore + peScore).toString(), idPatient: idPatient);
        textResult = 'Hasil pemeriksaan adalah $questioName';
        await ScoringResultController().create(data);
      } else {
        textResult = 'Hasil pemeriksaan bukan $questioName';
      }
    } else if (questioName == 'Nyeri Neuropatik') {
      if (sbjScore >= 5 && peScore >= 3) {
        ScoringResult data = ScoringResult(id: "1", type: questioName, value: (sbjScore + peScore).toString(), idPatient: idPatient);
        textResult = 'Hasil pemeriksaan adalah $questioName';
        await ScoringResultController().create(data);
      } else {
        textResult = 'Hasil pemeriksaan bukan $questioName';
      }
    } else if (questioName == 'Nyeri Sensitisasi Sentral') {
      if (sbjScore >= 8 && peScore >= 4) {
        ScoringResult data = ScoringResult(id: "1", type: questioName, value: (sbjScore + peScore).toString(), idPatient: idPatient);
        textResult = 'Hasil pemeriksaan adalah $questioName';
        await ScoringResultController().create(data);
      } else {
        textResult = 'Hasil pemeriksaan bukan $questioName';
      }
    } else {
      textResult = 'Hasil pemeriksaan bukan $questioName';
    }
  }

  @override
  void initState() {
    super.initState();
    genereteResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cAppBar(context, title: 'Hasil Pemeriksaan', centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [
            Container(
              width: context.width,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    textResult,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      (sbjScore + peScore).toString(),
                      style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: context.width / 2.8,
              child: ElevatedButton(
                onPressed: () async {
                  if (questioName == 'Nyeri Nosiseptif') {
                    Utils.goToNextPage('question-page', arguments: {'questioName': 'Nyeri Neuropatik', 'id_patient': idPatient});
                  } else if (questioName == 'Nyeri Neuropatik') {
                    Utils.goToNextPage('question-page', arguments: {'questioName': 'Nyeri Sensitisasi Sentral', 'id_patient': idPatient});
                  } else {
                    Get.offAllNamed('pain-result-page', arguments: {'id_patient': idPatient});
                  }
                },
                child: Text(
                  'Selanjutnya'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
