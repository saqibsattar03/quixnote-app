import 'package:json_annotation/json_annotation.dart';
part 'comment_model.g.dart';


@JsonSerializable(includeIfNull: false)
class CommentModel{
  CommentModel({this.id, required this.userId,required this.noteId, required this.comment, this.media});

  @JsonKey(name:"_id")
  final String? id;
  final String userId;
  final String noteId;
  final String comment;
  final String? media;

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}