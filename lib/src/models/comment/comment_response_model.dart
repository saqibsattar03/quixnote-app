import 'package:json_annotation/json_annotation.dart';
part 'comment_response_model.g.dart';

@JsonSerializable(includeIfNull: false)
class CommentResponseModel {
  CommentResponseModel(
      {required this.id,
      required this.noteId,
      required this.comment,
      this.createdAt,
      required this.fullName});

  @JsonKey(name: "_id")
  final String id;
  final String noteId;
  final String comment;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  final String fullName;
  factory CommentResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommentResponseModelToJson(this);
}
