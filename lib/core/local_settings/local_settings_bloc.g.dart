// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_settings_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocalSettingsStateImpl _$$LocalSettingsStateImplFromJson(
  Map<String, dynamic> json,
) => _$LocalSettingsStateImpl(
  local: json['local'] as String? ?? 'ar',
  isDarkMode: json['isDarkMode'] as bool? ?? false,
  currencyCode: json['currencyCode'] as String? ?? "SAR",
  englishFont: json['englishFont'] as String? ?? 'Roboto',
  arabicFont: json['arabicFont'] as String? ?? 'Cairo',
  isTable: json['isTable'] as bool? ?? false,
);

Map<String, dynamic> _$$LocalSettingsStateImplToJson(
  _$LocalSettingsStateImpl instance,
) => <String, dynamic>{
  'local': instance.local,
  'isDarkMode': instance.isDarkMode,
  'currencyCode': instance.currencyCode,
  'englishFont': instance.englishFont,
  'arabicFont': instance.arabicFont,
  'isTable': instance.isTable,
};
