import 'package:booqs_mobile/models/dictionary.dart';
import 'package:booqs_mobile/utils/booqs_on_web.dart';
import 'package:booqs_mobile/widgets/button/small_green_button.dart';
import 'package:flutter/material.dart';

class DictionaryWordRequestsButton extends StatelessWidget {
  const DictionaryWordRequestsButton({Key? key, required this.dictionary})
      : super(key: key);
  final Dictionary dictionary;

  @override
  Widget build(BuildContext context) {
    // 承認済の辞書リクエスト
    Widget _acceptedWordRequestsButton() {
      final String btnText = '辞書の改善履歴（${dictionary.acceptedWordRequestsCount}）';
      final String redirectPath =
          'dictionaries/${dictionary.publicUid}/accepted_word_requests';
      return InkWell(
        onTap: () {
          BooQsOnWeb.open(context, redirectPath);
        },
        child: SmallGreenButton(label: btnText, icon: Icons.history),
      );
    }

    // 保留中の辞書リクエスト
    Widget _pendingWordRequestsButton() {
      final int pendingRequestsCount = dictionary.pendingWordRequestsCount;
      if (pendingRequestsCount == 0) return Container();
      final String btnText = '$pendingRequestsCount件の審査中の編集';
      final String redirectPath =
          'dictionaries/${dictionary.publicUid}/pending_word_requests';
      return TextButton(
          onPressed: () {
            BooQsOnWeb.open(context, redirectPath);
          },
          child: Text(
            btnText,
            style: const TextStyle(color: Colors.green, fontSize: 16),
          ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_acceptedWordRequestsButton(), _pendingWordRequestsButton()],
    );
  }
}
