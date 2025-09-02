import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:screening_tools_android/app/controllers/question/question.dart';
import 'package:screening_tools_android/app/utils/utils.dart';
import 'package:screening_tools_android/resources/components/components.dart';

class QuestionTypePage extends StatefulWidget {
  const QuestionTypePage({super.key});

  @override
  State<QuestionTypePage> createState() => _QuestionTypePageState();
}

class _QuestionTypePageState extends State<QuestionTypePage> {
  List<String> questionsName = questions.map((e) => e.name).toSet().toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cAppBar(title: "Paindre Screening Tools"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [
            for (String questioName in questionsName)
              Column(
                children: [
                  ListTile(
                    onTap: () {
                      Utils.goToNextPage('question-page', arguments: {'questioName': questioName});
                      // debugPrint(questioName);
                    },
                    leading: Icon(MdiIcons.chevronRight, size: 30),
                    title: Text(questioName, style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
                    tileColor: Colors.white,
                    style: ListTileStyle.drawer,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    horizontalTitleGap: 6,
                    minLeadingWidth: 0,
                    minVerticalPadding: 0,
                    visualDensity: VisualDensity.compact,
                    contentPadding: const EdgeInsets.symmetric(),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
