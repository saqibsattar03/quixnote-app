import 'package:json_annotation/json_annotation.dart';

part 'note_model.g.dart';

@JsonSerializable(includeIfNull: false)
class NoteModel {
  @JsonKey(name: '_id')
  String? id;
  String? userId;

  // @JsonKey(includeIfNull: false)
  // String? projectName;
  String? title;
  String? description;
  String? priority;

  // @JsonKey(includeIfNull: false)
  // List<String>? media;
  String? media;
  DateTime? deadline;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  NoteModel({
    this.id,
    this.userId,
    // this.projectName,
    this.title,
    this.description,
    this.priority,
    this.media,
    this.deadline,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}
