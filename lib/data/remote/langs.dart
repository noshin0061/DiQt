import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:booqs_mobile/utils/diqt_url.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/http_service.dart';
import 'package:booqs_mobile/utils/sanitizer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart';

class RemoteLangs {
  // Google翻訳
  static Future<Map?> googleTranslation(
      {required String original,
      required int sourceLangNumber,
      required int targetLangNumber}) async {
    try {
      final String sanitizedOriginal = Sanitizer.removeDiQtLink(original);

      final Map<String, dynamic> body = {
        'original': sanitizedOriginal,
        'source_lang_number': sourceLangNumber,
        'target_lang_number': targetLangNumber,
      };

      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/langs/google_translation');
      final Response res = await HttpService.post(
        url,
        body,
      );
      if (ErrorHandler.isErrorResponse(res)) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException {
      return null;
    } on SocketException {
      return null;
    } catch (e) {
      return null;
    }
  }

  // DeepL翻訳
  static Future<Map?> deeplTranslation(
      {required String original,
      required int sourceLangNumber,
      required int targetLangNumber}) async {
    try {
      final String sanitizedOriginal = Sanitizer.removeDiQtLink(original);

      // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
      final Map<String, dynamic> body = {
        'original': sanitizedOriginal,
        'source_lang_number': sourceLangNumber,
        'target_lang_number': targetLangNumber,
      };

      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/langs/deepl_translation');
      final Response res = await HttpService.post(
        url,
        body,
      );
      if (ErrorHandler.isErrorResponse(res)) return null;

      final Map resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException {
      return null;
    } on SocketException {
      return null;
    } catch (e) {
      return null;
    }
  }

  // 形態素解析による分かち書き
  static Future<Map?> wordSegmantation(String keyword, int langNumber) async {
    try {
      final String sanitizedKeyword = Sanitizer.removeDiQtLink(keyword);

      // Map<String, dynamic>をbobyで送信できる型に変換 ref: https://stackoverflow.com/questions/54598879/dart-http-post-with-mapstring-dynamic-as-body
      final Map<String, dynamic> body = {
        'keyword': sanitizedKeyword,
        'lang_number': langNumber,
      };

      final Uri url =
          Uri.parse('${DiQtURL.root()}/api/v1/mobile/langs/word_segmantation');
      final Response res = await HttpService.post(
        url,
        body,
      );
      if (res.statusCode != 200) return null;

      final Map? resMap = json.decode(res.body);
      return resMap;
    } on TimeoutException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } on SocketException catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      return null;
    }
  }
}
