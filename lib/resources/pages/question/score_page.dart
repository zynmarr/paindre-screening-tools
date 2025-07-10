import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:screening_tools_android/app/controllers/patient/patient.dart';
import 'package:screening_tools_android/app/controllers/scoring_result/scoring_result.dart';
import 'package:screening_tools_android/app/routes/routes.dart';
import 'package:screening_tools_android/resources/components/components.dart';
import 'package:screening_tools_android/resources/pages/question/pain_result_page.dart';
import 'package:screening_tools_android/resources/pages/question/question_page.dart';

class ScoreArguments {
  final String question;
  final Patient patient;
  final int sbjScore;
  final int peScore;

  ScoreArguments({required this.question, required this.patient, required this.sbjScore, required this.peScore});
}

class ScorePage extends StatefulWidget {
  final String question;
  final Patient patient;
  final int sbjScore;
  final int peScore;
  const ScorePage({super.key, required this.question, required this.patient, required this.sbjScore, required this.peScore});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  String textResult = '';

  String dateFormat = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()).toString();

  genereteResult() async {
    if (widget.question == 'Nyeri Nosiseptif') {
      if (widget.sbjScore >= 5 && widget.peScore >= 1) {
        ScoringResult data = ScoringResult(type: widget.question, value: (widget.sbjScore + widget.peScore).toString(), createdAt: dateFormat);
        // textResult = 'Hasil pemeriksaan adalah ${widget.question}';
        textResult = 'text.resultIs'.tr + 'pain.nociceptive'.tr;

        await PatientController().createQuestionnareScore(patient: widget.patient, data: data);
      } else {
        textResult = 'text.resultIsNot'.tr + 'pain.nociceptive'.tr;
      }
    } else if (widget.question == 'Nyeri Neuropatik') {
      if (widget.sbjScore >= 5 && widget.peScore >= 3) {
        ScoringResult data = ScoringResult(type: widget.question, value: (widget.sbjScore + widget.peScore).toString(), createdAt: dateFormat);
        textResult = 'text.resultIs'.tr + 'pain.neuropathic'.tr;
        await PatientController().createQuestionnareScore(patient: widget.patient, data: data);
      } else {
        textResult = 'text.resultIsNot'.tr + 'pain.neuropathic'.tr;
      }
    } else if (widget.question == 'Nyeri Sensitisasi Sentral') {
      if (widget.sbjScore >= 8 && widget.peScore >= 4) {
        ScoringResult data = ScoringResult(type: widget.question, value: (widget.sbjScore + widget.peScore).toString(), createdAt: dateFormat);
        textResult = 'text.resultIs'.tr + 'pain.centralSensitization'.tr;
        await PatientController().createQuestionnareScore(patient: widget.patient, data: data);
      } else {
        textResult = 'text.resultIsNot'.tr + 'pain.centralSensitization'.tr;
      }
    } else {
      textResult = 'text.painResultData'.tr; // Default text for no specific pain found
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
      appBar: cAppBar(title: 'checkUpResult'.tr, centerTitle: true),
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
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: context.width,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(offset: Offset(1, 2), color: Colors.black45, blurRadius: 4)],
                  ),
                  child: Column(
                    children: [
                      Text(textResult, textAlign: TextAlign.center, style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 26,
                        child: Text(
                          (widget.sbjScore + widget.peScore).toString(),
                          style: context.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: context.width / 2.8,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (widget.question == 'Nyeri Nosiseptif') {
                        Get.offAllNamed(
                          Routes.question,
                          arguments: QuestionArguments(question: "Nyeri Neuropatik", patient: widget.patient),
                          predicate: (route) => route.settings.name == Routes.home,
                        );
                      } else if (widget.question == 'Nyeri Neuropatik') {
                        Get.offAllNamed(
                          Routes.question,
                          arguments: QuestionArguments(question: "Nyeri Sensitisasi Sentral", patient: widget.patient),
                          predicate: (route) => route.settings.name == Routes.home,
                        );
                      } else {
                        Get.offAllNamed(
                          Routes.painResult,
                          arguments: PainResultArguments(patient: widget.patient),
                          predicate: (route) => route.settings.name == Routes.home,
                        );
                      }
                    },
                    child: Text(
                      'next'.tr.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
