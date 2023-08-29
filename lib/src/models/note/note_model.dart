import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'note_model.g.dart';

@JsonSerializable()
class NoteModel {
  @JsonKey(includeIfNull: false)
  String? id;
  @JsonKey(includeIfNull: false)
  String? userId;
  @JsonKey(includeIfNull: false)
  String? projectName;
  @JsonKey(includeIfNull: false)
  String? title;
  @JsonKey(includeIfNull: false)
  String? description;
  @JsonKey(includeIfNull: false)
  String? priority;
  // @JsonKey(includeIfNull: false)
  // List<String>? media;
  @JsonKey(includeIfNull: false)
  String? media;
  @JsonKey(includeIfNull: false)
  String? deadline;
  @JsonKey(includeIfNull: false)
  DateTime? createdAt;
  @JsonKey(includeIfNull: false)
  DateTime? updatedAt;
  @JsonKey(includeIfNull: false)
  int? v;

  NoteModel({
    this.id,
    this.userId,
    this.projectName,
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
