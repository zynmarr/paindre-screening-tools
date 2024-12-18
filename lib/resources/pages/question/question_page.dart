import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:screening_tools_android/app/controllers/question/question.dart';
import 'package:screening_tools_android/app/utils/utils.dart';
import 'package:screening_tools_android/resources/components/components.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  String questioName = Get.arguments['questioName'];
  String idPatient = Get.arguments['id_patient'];

  int sbjScore = 0;
  int peScore = 0;

  List questionSbj = [];
  List questionPE = [];

  @override
  void initState() {
    questionSbj = questions.where((element) => element.name == questioName && element.type == 'Subjective').map((e) => {'quest': e.toMap(), 'value': ''}).toList();
    questionPE = questions.where((element) => element.name == questioName && element.type == 'Physical examination').map((e) => {'quest': e.toMap(), 'value': ''}).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        final dialog = cDialog(
          context,
          middleText: "Apakah anda yakin ingin keluar dari halaman ini?",
          onSucces: () => Get.offAllNamed('home-page'),
          onCancel: () => Get.back(),
        );

        return dialog;
      },
      child: Scaffold(
        appBar: cAppBar(context, title: questioName, centerTitle: true),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [
              Container(
                width: context.width,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                color: Colors.white,
                child: Column(
                  children: [
                    Text(
                      'Pemeriksaan Subjektif',
                      style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 14),
                    for (var questionSub in questionSbj)
                      Container(
                        margin: EdgeInsets.only(bottom: questionSub == questionSbj.last ? 0 : 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  questionSub['quest']['title'],
                                  maxLines: 10,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  questionSub['quest']['subTitle'],
                                  maxLines: 6,
                                  style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (questionSub['value'] != true) {
                                      setState(() {
                                        questionSub['value'] = true;
                                        sbjScore += 1;
                                        print(sbjScore);
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: questionSub['value'] == true ? Colors.green[700] : Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.green[700]!),
                                    ),
                                    child: Row(
                                      children: [
                                        if (questionSub['value'] == true)
                                          Icon(
                                            MdiIcons.check,
                                            size: context.textTheme.bodyMedium!.fontSize,
                                            color: Colors.white,
                                          ),
                                        if (questionSub['value'] == true) const SizedBox(width: 4),
                                        Text(
                                          'Iya',
                                          style: context.textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: questionSub['value'] == true ? Colors.white : Colors.green[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    if (questionSub['value'] != false) {
                                      setState(() {
                                        if (sbjScore != 0 && questionSub['value'] != '') {
                                          sbjScore -= 1;
                                        }
                                        questionSub['value'] = false;
                                        print(sbjScore);
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: questionSub['value'] == false ? Colors.red[700] : Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.red[700]!),
                                    ),
                                    child: Row(
                                      children: [
                                        if (questionSub['value'] == false)
                                          Icon(
                                            MdiIcons.close,
                                            size: context.textTheme.bodyMedium!.fontSize,
                                            color: Colors.white,
                                          ),
                                        if (questionSub['value'] == false) const SizedBox(width: 4),
                                        Text(
                                          'Tidak',
                                          style: context.textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: questionSub['value'] == false ? Colors.white : Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: context.width,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                color: Colors.white,
                child: Column(
                  children: [
                    Text(
                      'Pemeriksaan Fisik',
                      style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 14),
                    for (var questionSub in questionPE)
                      Container(
                        margin: EdgeInsets.only(bottom: questionSub == questionSbj.last ? 0 : 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  questionSub['quest']['title'],
                                  maxLines: 10,
                                  style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (questionSub['value'] != true) {
                                      setState(() {
                                        questionSub['value'] = true;
                                        peScore += 1;
                                        print(peScore);
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: questionSub['value'] == true ? Colors.green[700] : Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.green[700]!),
                                    ),
                                    child: Row(
                                      children: [
                                        if (questionSub['value'] == true)
                                          Icon(
                                            MdiIcons.check,
                                            size: context.textTheme.bodyMedium!.fontSize,
                                            color: Colors.white,
                                          ),
                                        if (questionSub['value'] == true) const SizedBox(width: 4),
                                        Text(
                                          'Iya',
                                          style: context.textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: questionSub['value'] == true ? Colors.white : Colors.green[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    if (questionSub['value'] != false) {
                                      setState(() {
                                        if (peScore != 0 && questionSub['value'] != '') {
                                          peScore -= 1;
                                        }
                                        questionSub['value'] = false;
                                        print(peScore);
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: questionSub['value'] == false ? Colors.red[700] : Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.red[700]!),
                                    ),
                                    child: Row(
                                      children: [
                                        if (questionSub['value'] == false)
                                          Icon(
                                            MdiIcons.close,
                                            size: context.textTheme.bodyMedium!.fontSize,
                                            color: Colors.white,
                                          ),
                                        if (questionSub['value'] == false) const SizedBox(width: 4),
                                        Text(
                                          'Tidak',
                                          style: context.textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: questionSub['value'] == false ? Colors.white : Colors.red[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: context.width,
                child: ElevatedButton(
                  onPressed: () async {
                    cDialog(
                      context,
                      middleText: "Apakah anda sudah yakin?",
                      onSucces: () => Utils.goToNextPage('score-page', arguments: {'sbj_score': sbjScore, 'pe_score': peScore, 'name': questioName, 'id_patient': idPatient}),
                      onCancel: () => Get.back(),
                    );
                  },
                  child: Text(
                    'Periksa Hasil',
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
