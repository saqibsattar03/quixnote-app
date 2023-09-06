import 'package:json_annotation/json_annotation.dart';

part 'sign_up_model.g.dart';

@JsonSerializable(includeIfNull: false)
class SignUpModel {
  @JsonKey(name: '_id')
  String? id;
  String fullName;
  String email;
  String? password;
  String? role;
  String? loginVia;
  List? scopes;
  String? idToken;
  bool? notificationPreference;
  bool? isSubscribed;
  bool? isVerified;
  String? city;
  String? country;
  String? status;
  String? state;

  SignUpModel({
    required this.fullName,
    required this.email,
    this.id,
    this.password,
    this.idToken,
    this.role,
    this.status,
    this.loginVia,
    this.scopes,
    this.notificationPreference,
    this.isSubscribed,
    this.isVerified,
    this.city,
    this.country,
    this.state,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);
}

@JsonSerializable()
class TokenModel {
  @JsonKey(name: 'access_token')
  final String accessToken;

  TokenModel({required this.accessToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokenModelToJson(this);
}
