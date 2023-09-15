import 'package:flutter/cupertino.dart';
import 'package:quix_note/src/models/comment/comment_response_model.dart';
import 'package:quix_note/src/service/api/comment_api_config.dart';

import '../utils/api_errors.dart';

class NotesController extends ChangeNotifier{

  // NotesController._();

  // static final _instance = NotesController._();
  //
  // static NotesController get instance => _instance;

  var _isLoading = true;

  bool get isLoading => _isLoading;

  ApiError? _error;

  bool get hasError => _error != null;

  ApiError get error => _error!;

  List<CommentResponseModel>? _comment;

  List<CommentResponseModel>? get comment => _comment;

  Future<void> getAllComment(String noteId) async {
    try {
      _error = null;
      _isLoading = true;
      notifyListeners();
      _comment = await CommentApiConfig().getAllCommentByNoteId(noteId: noteId);
    } catch (_) {
      _error = ApiError.withDioError(_);
    }
    _isLoading = false;
    notifyListeners();
  }
  Future<void> refresh(String noteId) async {
    await getAllComment(noteId);
  }

}