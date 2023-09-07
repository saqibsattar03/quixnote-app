import 'package:quix_note/src/models/comment/comment_model.dart';
import 'package:quix_note/src/models/comment/comment_response_model.dart';
import 'package:quix_note/src/service/api/base_service.dart';

final class CommentApiConfig extends BaseApi {
  Future<CommentModel> postComment({required CommentModel commentModel}) async {
    try {
      final response =
          await postRequest(url: "/comment", data: commentModel.toJson());
      return CommentModel.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }

  Future<List<CommentResponseModel>> getAllCommentByNoteId(
      {required String noteId}) async {
    try {
      final response = await getRequest(url: "/comment/all/$noteId");
      print(
          "${response.data}------------------------------------------------------------");
      return response.data
          .map<CommentResponseModel>(
              (json) => CommentResponseModel.fromJson(json))
          .toList();
    } catch (_) {
      rethrow;
    }
  }
}
