import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:screening_tools_android/app/controllers/patient/patient.dart';
import 'package:screening_tools_android/app/controllers/question/question_controller.dart';
import 'package:screening_tools_android/app/routes/routes.dart';
import 'package:screening_tools_android/resources/components/components.dart';
import 'package:screening_tools_android/resources/pages/question/score_page.dart';

class QuestionArguments {
  final String question;
  final Patient patient;

  QuestionArguments({required this.question, required this.patient});
}
class QuestionPageProvider extends StatelessWidget {
  final QuestionArguments args;
  const QuestionPageProvider({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => QuestionController(), child: QuestionPage(question: args.question, patient: args.patient));
  }
}

class QuestionPage extends StatefulWidget {
  final String question;
  final Patient patient;
  const QuestionPage({super.key, required this.question, required this.patient});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuestionController>().initialize(widget.question);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<QuestionController>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didpop, result) {
        if (didpop) return;
        cDialog(context, middleText: 'dialog.exitPage'.tr, onSucces: () => Get.offAllNamed(Routes.home), onCancel: () => Get.back());
      },
      child: Scaffold(
        appBar: cAppBar(title: controller.barTitle.tr, centerTitle: true), // Ambil title dari controller
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [
              _buildQuestionSection(
                context: context,
                title: 'questions.type.1'.tr,
                questions: controller.questionSbj,
                onAnswer: (index, answer) => context.read<QuestionController>().answerSubjective(index, answer),
              ),
              const SizedBox(height: 20),
              _buildQuestionSection(
                context: context,
                title: 'questions.type.2'.tr,
                questions: controller.questionPE,
                onAnswer: (index, answer) => context.read<QuestionController>().answerPhysical(index, answer),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: context.width,
                child: ElevatedButton(
                  onPressed: () {
                    cDialog(
                      context,
                      middleText: 'dialog.sure'.tr,
                      onSucces:
                          () => Get.offAllNamed(
                            Routes.score,
                            arguments: ScoreArguments(
                              question: widget.question,
                              patient: widget.patient,
                              sbjScore: controller.sbjScore, // Ambil skor dari controller
                              peScore: controller.peScore, // Ambil skor dari controller
                            ),
                            predicate: (route) => route.settings.name == Routes.home,
                          ),
                      onCancel: () => Get.back(),
                    );
                  },
                  child: Text(
                    'button.checkResult'.tr,
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
Widget _buildQuestionSection({
  required BuildContext context,
  required String title,
  required List<Map<String, dynamic>> questions,
  required Function(int, bool) onAnswer,
}) {
  return Container(
    width: context.width,
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [BoxShadow(offset: Offset(1, 2), color: Colors.black45, blurRadius: 4)],
    ),
    child: Column(
      children: [
        Text(title, style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: questions.length,
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            final questionItem = questions[index];
            return _buildQuestionItem(context: context, questionData: questionItem, onAnswer: (answer) => onAnswer(index, answer));
          },
        ),
      ],
    ),
  );
}
Widget _buildQuestionItem({required BuildContext context, required Map<String, dynamic> questionData, required Function(bool) onAnswer}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(questionData['quest']['title'], maxLines: 10),
      const SizedBox(height: 4),
      Text(questionData['quest']['subTitle'], maxLines: 6, style: context.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Row(
        children: [
          _buildAnswerButton(context, text: 'yes'.tr, isSelected: questionData['value'] == true, isYesButton: true, onTap: () => onAnswer(true)),
          const SizedBox(width: 8),
          _buildAnswerButton(context, text: 'no'.tr, isSelected: questionData['value'] == false, isYesButton: false, onTap: () => onAnswer(false)),
        ],
      ),
    ],
  );
}
Widget _buildAnswerButton(
  BuildContext context, {
  required String text,
  required bool isSelected,
  required bool isYesButton,
  required VoidCallback onTap,
}) {
  final Color selectedColor = isYesButton ? Colors.green[700]! : Colors.red[700]!;
  final Color unselectedColor = Colors.white;
  final Color borderColor = isYesButton ? Colors.green[700]! : Colors.red[700]!;
  final Color textColor = isSelected ? Colors.white : (isYesButton ? Colors.green[700]! : Colors.red[700]!);

  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: isSelected ? selectedColor : unselectedColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          if (isSelected) Icon(isYesButton ? MdiIcons.check : MdiIcons.close, size: context.textTheme.bodyMedium!.fontSize, color: Colors.white),
          if (isSelected) const SizedBox(width: 4),
          Text(text, style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: textColor)),
        ],
      ),
    ),
  );
}
