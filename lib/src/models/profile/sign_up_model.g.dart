// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpModel _$SignUpModelFromJson(Map<String, dynamic> json) => SignUpModel(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
      role: json['role'] as String?,
      loginVia: json['loginVia'] as String?,
      scopes: json['scopes'] as String?,
      notificationPreference: json['notificationPreference'] as bool?,
      isSubscribed: json['isSubscribed'] as bool?,
      isVerified: json['isVerified'] as bool?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$SignUpModelToJson(SignUpModel instance) {
  final val = <String, dynamic>{
    'fullName': instance.fullName,
    'email': instance.email,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('password', instance.password);
  writeNotNull('role', instance.role);
  writeNotNull('loginVia', instance.loginVia);
  writeNotNull('scopes', instance.scopes);
  writeNotNull('notificationPreference', instance.notificationPreference);
  writeNotNull('isSubscribed', instance.isSubscribed);
  writeNotNull('isVerified', instance.isVerified);
  writeNotNull('city', instance.city);
  writeNotNull('country', instance.country);
  writeNotNull('state', instance.state);
  return val;
}
