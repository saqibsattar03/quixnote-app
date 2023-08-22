import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'sign_in_model.g.dart';

@JsonSerializable()
class SignInModel {
  @JsonKey(name: "email")
  String? email;
  @JsonKey(includeIfNull: false)
  String? password;

  SignInModel({
    this.email,
    this.password,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) => _$SignInModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignInModelToJson(this);
}