import 'package:quix_note/src/models/note/note_model.dart';
import 'package:quix_note/src/models/note/search_and_filter_model.dart';
import 'package:quix_note/src/service/api/base_service.dart';

final class NoteApiConfig extends BaseApi {
  Future<NoteModel> creteNote({required NoteModel createNoteModel}) async {
    try {
      final response =
          await postRequest(url: "/notes", data: createNoteModel.toJson());
      return NoteModel.fromJson(response.data);
    } catch (_) {
      rethrow;
    }
  }

  Future<List<NoteModel>> getAllNotes() async {
    try {
      final response = await getRequest(url: "/notes/all-by-userid");
      return response.data
          .map<NoteModel>((json) => NoteModel.fromJson(json))
          .toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<List<NoteModel>> filterNotes({
    required SearchAndFilterModel model,
  }) async {
    try {
      final response = await postRequest(
        url: "/notes/filter",
        data: model.toJson(),
      );
      final list = response.data
          .map<NoteModel>((json) => NoteModel.fromJson(json))
          .toList();
      return list;
    } catch (_) {
      rethrow;
    }
  }
}
