import 'package:booqs_mobile/widgets/shared/markdown_without_diqt_link.dart';
import 'package:flutter/material.dart';

class QuizChoiceButton extends StatelessWidget {
  const QuizChoiceButton(
      {Key? key, required this.answerText, required this.selected})
      : super(key: key);
  final String answerText;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        margin: const EdgeInsets.symmetric(vertical: 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.green,
        ),
        child: MarkdownWithoutDiQtLink(
          text: answerText,
          textStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          selectable: false,
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: MarkdownWithoutDiQtLink(
        text: answerText,
        textStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
        selectable: false,
      ),
    );
  }
}
