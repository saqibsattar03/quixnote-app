import 'package:json_annotation/json_annotation.dart';

part 'sign_up_model.g.dart';

@JsonSerializable()
class SignUpModel {
  @JsonKey(name: "fullName")
  String fullName;
  @JsonKey(name: "email")
  String email;
  @JsonKey(includeIfNull: false)
  String? password;
  @JsonKey(includeIfNull: false)
  String? role;
  @JsonKey(includeIfNull: false)
  String? loginVia;
  @JsonKey(includeIfNull: false)
  String? scopes;
  @JsonKey(includeIfNull: false)
  bool? notificationPreference;
  @JsonKey(includeIfNull: false)
  bool? isSubscribed;
  @JsonKey(includeIfNull: false)
  bool? isVerified;
  @JsonKey(includeIfNull: false)
  String? city;
  @JsonKey(includeIfNull: false)
  String? country;
  @JsonKey(includeIfNull: false)
  String? state;

  SignUpModel({
    required this.fullName,
    required this.email,
    this.password,
    this.role,
    this.loginVia,
    this.scopes,
    this.notificationPreference,
    this.isSubscribed,
    this.isVerified,
    this.city,
    this.country,
    this.state,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => _$SignUpModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);
}