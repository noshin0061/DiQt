import 'package:booqs_mobile/components/sentence_request_comment/item/content.dart';
import 'package:booqs_mobile/components/sentence_request_comment/item/edit_form.dart';
import 'package:booqs_mobile/data/remote/sentence_request_comments.dart';
import 'package:booqs_mobile/i18n/translations.g.dart';
import 'package:booqs_mobile/models/sentence_request_comment.dart';
import 'package:booqs_mobile/utils/error_handler.dart';
import 'package:booqs_mobile/utils/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SentenceRequestCommentItem extends ConsumerStatefulWidget {
  const SentenceRequestCommentItem(
      {super.key, required this.sentenceRequestComment});
  final SentenceRequestComment sentenceRequestComment;

  @override
  SentenceRequestCommentItemState createState() =>
      SentenceRequestCommentItemState();
}

class SentenceRequestCommentItemState
    extends ConsumerState<SentenceRequestCommentItem> {
  late SentenceRequestComment sentenceRequestComment;
  final TextEditingController _commentController = TextEditingController();
  bool _isEdit = false;
  bool _isRequesting = false;

  @override
  void initState() {
    super.initState();
    sentenceRequestComment = widget.sentenceRequestComment;
    _commentController.text = sentenceRequestComment.body;
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  Future<void> _save() async {
    EasyLoading.show();
    final Map resMap = await RemoteSentenceRequestComments.update(
        sentenceRequestCommentId: sentenceRequestComment.id,
        text: _commentController.text);
    EasyLoading.dismiss();
    if (!mounted) return;
    if (ErrorHandler.isErrorMap(resMap)) {
      ErrorHandler.showErrorToast(context, resMap);
      setState(() {
        _isEdit = false;
        _isRequesting = false;
      });
      return;
    }
    sentenceRequestComment =
        SentenceRequestComment.fromJson(resMap['sentence_request_comment']);
    setState(() {
      _isEdit = false;
      _isRequesting = false;
      sentenceRequestComment;
    });
    Toasts.showSimple(context, t.shared.create_succeeded);
  }

  @override
  Widget build(BuildContext context) {
    if (_isEdit) {
      return SentenceRequestCommentItemEditForm(
          sentenceRequestComment: sentenceRequestComment,
          commentController: _commentController,
          onSave: () {
            if (_isRequesting) return;
            _save();
          });
    }

    return SentenceRequestCommentItemContent(
      sentenceRequestComment: sentenceRequestComment,
      editPressed: () {
        _commentController.text = sentenceRequestComment.body;
        setState(() => _isEdit = true);
      },
    );
  }
}
