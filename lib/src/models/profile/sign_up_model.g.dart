// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpModel _$SignUpModelFromJson(Map<String, dynamic> json) => SignUpModel(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      id: json['id'] as String?,
      password: json['password'] as String?,
      idToken: json['idToken'] as String?,
      role: json['role'] as String?,
      loginVia: json['loginVia'] as String?,
      scopes: json['scopes'] as List<dynamic>?,
      notificationPreference: json['notificationPreference'] as bool?,
      isSubscribed: json['isSubscribed'] as bool?,
      isVerified: json['isVerified'] as bool?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$SignUpModelToJson(SignUpModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['fullName'] = instance.fullName;
  val['email'] = instance.email;
  writeNotNull('password', instance.password);
  writeNotNull('role', instance.role);
  writeNotNull('loginVia', instance.loginVia);
  writeNotNull('scopes', instance.scopes);
  writeNotNull('idToken', instance.idToken);
  writeNotNull('notificationPreference', instance.notificationPreference);
  writeNotNull('isSubscribed', instance.isSubscribed);
  writeNotNull('isVerified', instance.isVerified);
  writeNotNull('city', instance.city);
  writeNotNull('country', instance.country);
  writeNotNull('state', instance.state);
  return val;
}

TokenModel _$TokenModelFromJson(Map<String, dynamic> json) => TokenModel(
      accessToken: json['access_token'] as String,
    );

Map<String, dynamic> _$TokenModelToJson(TokenModel instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
    };
