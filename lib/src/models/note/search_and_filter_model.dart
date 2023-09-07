import 'package:json_annotation/json_annotation.dart';
part 'search_and_filter_model.g.dart';

@JsonSerializable()
class SearchAndFilterModel {
  SearchAndFilterModel({
    this.title,
    this.createdAt,
    this.priority,
  });

  final String? title;
  final String? createdAt;
  final String? priority;

  factory SearchAndFilterModel.fromJson(Map<String, dynamic> json) =>
      _$SearchAndFilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchAndFilterModelToJson(this);
}
