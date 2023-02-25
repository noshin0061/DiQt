import 'package:booqs_mobile/components/word/item/ipa.dart';
import 'package:booqs_mobile/data/provider/word.dart';
import 'package:booqs_mobile/models/word.dart';
import 'package:booqs_mobile/pages/word/show.dart';
import 'package:booqs_mobile/components/word/item/edit_button.dart';
import 'package:booqs_mobile/components/word/item/entry.dart';
import 'package:booqs_mobile/components/word/item/meaning.dart';
import 'package:booqs_mobile/components/word/item/reading.dart';
import 'package:booqs_mobile/components/word/item/review_button.dart';
import 'package:booqs_mobile/components/word/item/sentence.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordListItem extends ConsumerWidget {
  const WordListItem({Key? key, required this.word}) : super(key: key);
  final Word word;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(wordProvider.notifier).state = word;
        WordShowPage.push(context, word.id);
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                WordItemEntry(word: word),
                WordItemReading(word: word),
                WordItemIPA(word: word),
                const SizedBox(
                  height: 10,
                ),
                WordItemMeaning(word: word),
                const SizedBox(
                  height: 24,
                ),
                WordItemReviewButton(word: word),
                const SizedBox(
                  height: 24,
                ),
                WordItemSentence(word: word),
                WordItemEditButton(
                  word: word,
                  isShow: false,
                ),
              ])),
    );
  }
}
