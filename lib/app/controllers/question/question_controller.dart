import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'question.dart';

class QuestionController extends ChangeNotifier {
  int sbjScore = 0;
  int peScore = 0;
  List<Map<String, dynamic>> questionSbj = [];
  List<Map<String, dynamic>> questionPE = [];
  String barTitle = '';
  void initialize(String questionName) {
    sbjScore = 0;
    peScore = 0;
    questionSbj = [];
    questionPE = [];
    if (questionName == 'Nyeri Nosiseptif' || questionName == 'pain.nociceptive') {
      barTitle = 'pain.nociceptive'; // Gunakan key, bukan .tr
    } else if (questionName == 'Nyeri Neuropatik' || questionName == 'pain.neuropathic') {
      barTitle = 'pain.neuropathic';
    } else if (questionName == 'Nyeri Sensitisasi Sentral' || questionName == 'pain.centralSensitization') {
      barTitle = 'pain.centralSensitization';
    }
    questionSbj =
        questions
            .where((element) => element.name == questionName && element.type == 'Subjective')
            .map((e) => {'quest': e.toMap(), 'value': ''})
            .toList();

    questionPE =
        questions
            .where((element) => element.name == questionName && element.type == 'Physical examination')
            .map((e) => {'quest': e.toMap(), 'value': ''})
            .toList();

    notifyListeners();
  }
  void answerSubjective(int index, bool answer) {
    var question = questionSbj[index];
    final previousAnswer = question['value'];
    if (previousAnswer == !answer) {
      sbjScore += (answer ? 1 : -1);
    } else if (previousAnswer == '') {
      if (answer) sbjScore++;
    }

    question['value'] = answer;
    notifyListeners(); // Memberi tahu UI untuk melakukan rebuild
  }

  void answerPhysical(int index, bool answer) {
    var question = questionPE[index];
    final previousAnswer = question['value'];
    if (previousAnswer == !answer) {
      peScore += (answer ? 1 : -1);
    } else if (previousAnswer == '') {
      if (answer) peScore++;
    }

    question['value'] = answer;
    notifyListeners();
  }
}
