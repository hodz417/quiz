// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchResultImpl _$$SearchResultImplFromJson(Map<String, dynamic> json) =>
    _$SearchResultImpl(
      organic: (json['organic'] as List<dynamic>)
          .map((e) => OrganicResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SearchResultImplToJson(_$SearchResultImpl instance) =>
    <String, dynamic>{'organic': instance.organic};

_$OrganicResultImpl _$$OrganicResultImplFromJson(Map<String, dynamic> json) =>
    _$OrganicResultImpl(
      title: json['title'] as String,
      link: json['link'] as String,
    );

Map<String, dynamic> _$$OrganicResultImplToJson(_$OrganicResultImpl instance) =>
    <String, dynamic>{'title': instance.title, 'link': instance.link};
