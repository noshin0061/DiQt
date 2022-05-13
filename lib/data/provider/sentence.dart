import 'package:booqs_mobile/data/remote/sentences.dart';
import 'package:booqs_mobile/models/sentence.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sentenceProvider = StateProvider<Sentence?>((ref) => null);
final asyncSentenceProvider = FutureProvider<Sentence?>((ref) async {
  final int? sentenceId =
      ref.watch(sentenceProvider.select((sentence) => sentence?.id));
  if (sentenceId == null) return null;

  final Map? resMap = await RemoteSentences.show(sentenceId);
  if (resMap == null) return null;
  final Sentence sentence = Sentence.fromJson(resMap['sentence']);
  ref.read(sentenceProvider.notifier).state = sentence;
  return sentence;
});

// ref: https://riverpod.dev/ja/docs/concepts/modifiers/family
// 【重要】 オブジェクトが一定ではない場合は autoDispose 修飾子との併用が望ましい
// family を使って検索フィールドの入力値をプロバイダに渡す場合、その入力値は頻繁に変わる上に同じ値が再利用されることはありません。
// おまけにプロバイダは参照されなくなっても破棄されないのがデフォルトの動作であるため、この場合はメモリリークにつながります。
final asyncSentenceFamily =
    FutureProvider.autoDispose.family<Sentence?, int>((ref, sentenceId) async {
  final Map? resMap = await RemoteSentences.show(sentenceId);
  if (resMap == null) return null;
  final Sentence sentence = Sentence.fromJson(resMap['sentence']);
  return sentence;
});
