// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivacyTerms _$PrivacyTermsFromJson(Map<String, dynamic> json) => PrivacyTerms(
      id: json['_id'] as String,
      clause: json['clause'] as String,
      description: json['description'] as String,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );

Map<String, dynamic> _$PrivacyTermsToJson(PrivacyTerms instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'clause': instance.clause,
      'description': instance.description,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };
