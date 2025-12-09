import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screening_tools_android/app/controllers/patient/patient.dart';
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
  late Future<String> _resultFuture;
  final PatientController _patientController = PatientController();

  @override
  void initState() {
    super.initState();
    _resultFuture = _patientController.processAndSaveScore(
      question: widget.question,
      patient: widget.patient,
      sbjScore: widget.sbjScore,
      peScore: widget.peScore,
    );
  }

  @override
  Widget build(BuildContext context) {
    double gWidth = context.width / 2.2;
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
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: gWidth,
                  width: gWidth,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://lh3.googleusercontent.com/pw/AP1GczO9egAuF1P-qsdsxxQ4CTCETHxXNEB3HDLRRZwuZm1gD5na9vERZtAsNDOWxVW4eVwo8-7nlCOUG6y5Bhk0JEVKcfkY8YL07ZlG9XRPhwX5BwhaDU1iEHLxfCPpOjlyRiO0va3YOw7Dh-oyNjqDvVg=w500-h500-s-no-gm',
                    filterQuality: FilterQuality.high,
                    fadeOutDuration: Duration(milliseconds: 500),
                    fadeInDuration: Duration(milliseconds: 300),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  width: context.width,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(offset: Offset(1, 2), color: Colors.black45, blurRadius: 4)],
                  ),
                  child: FutureBuilder<String>(
                    future: _resultFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text('Terjadi kesalahan saat memproses skor.', textAlign: TextAlign.center);
                      }
                      return Column(
                        children: [
                          Text(
                            snapshot.data ?? 'Tidak ada hasil.',
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                          ),
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
                      );
                    },
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
