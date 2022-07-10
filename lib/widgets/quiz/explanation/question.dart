import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/models/quiz.dart';
import 'package:booqs_mobile/services/sanitizer.dart';
import 'package:booqs_mobile/utils/markdown/diqt_link_builder.dart';
import 'package:booqs_mobile/utils/markdown/diqt_link_syntax.dart';
import 'package:booqs_mobile/widgets/shared/item_label.dart';
import 'package:booqs_mobile/widgets/shared/text_with_link.dart';
import 'package:booqs_mobile/widgets/shared/tts_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class QuizExplanationQuestion extends StatelessWidget {
  const QuizExplanationQuestion({Key? key, required this.quiz})
      : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    Widget _question() {
      /* final Dictionary? dictionary = quiz.dictionary;
      final int langNumberOfEntry = dictionary?.langNumberOfEntry ?? 0;
      if (quiz.langNumberOfQuestion == langNumberOfEntry) {
        return TextWithLink(
          text: quiz.question,
          langNumber: quiz.langNumberOfQuestion,
          dictionaryId: quiz.dictionaryId,
          autoLinkEnabled: true,
          crossAxisAlignment: CrossAxisAlignment.center,
        );
      }
      return Text(quiz.question, style: const TextStyle(fontSize: 16)); */
      return SizedBox(
        width: double.infinity,
        child: MarkdownBody(
          data: quiz.question,
          shrinkWrap: true,
          builders: <String, MarkdownElementBuilder>{
            'diqtlink': DiQtLinkBuilder(),
          },
          inlineSyntaxes: [DiQtLinkSyntax(quiz.dictionaryId)],
        ),
      );
    }

    Widget _ttsBtn() {
      if (quiz.questionReadAloud) {
        // TTSできちんと読み上げるためにDiQtリンクを取り除いた平文を渡す
        final String questionPlainText =
            Sanitizer.removeDiQtLink(quiz.question);
        return Container(
          margin: const EdgeInsets.only(top: 4),
          alignment: Alignment.center,
          child: TtsButton(
            speechText: questionPlainText,
            langNumber: quiz.langNumberOfQuestion,
          ),
        );
      }
      return Container();
    }

    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SharedItemLabel(text: '問題'),
          const SizedBox(height: 16),
          _question(),
          _ttsBtn(),
          const SizedBox(height: 24),
        ]);
  }
}
