import 'package:json_annotation/json_annotation.dart';

part 'privacy.g.dart';

@JsonSerializable()
class PrivacyTerms {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "clause")
  String clause;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "lastUpdated")
  DateTime lastUpdated;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "__v")
  int v;

  PrivacyTerms({
    required this.id,
    required this.clause,
    required this.description,
    required this.lastUpdated,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory PrivacyTerms.fromJson(Map<String, dynamic> json) =>
      _$PrivacyTermsFromJson(json);

  Map<String, dynamic> toJson() => _$PrivacyTermsToJson(this);
}
