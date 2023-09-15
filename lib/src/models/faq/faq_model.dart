import 'package:json_annotation/json_annotation.dart';
part 'faq_model.g.dart';

@JsonSerializable(includeIfNull: false)
class FaqModel {
  FaqModel({required this.question, required this.answer});

  final String question;
  final String answer;

  factory FaqModel.fromJson(Map<String, dynamic> json) =>
      _$FaqModelFromJson(json);
  Map<String, dynamic> toJson() => _$FaqModelToJson(this);
}
