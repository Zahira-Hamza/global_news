// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'News_Sources.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsSources _$NewsSourcesFromJson(Map<String, dynamic> json) => NewsSources(
      status: json['status'] as String?,
      sources: (json['sources'] as List<dynamic>?)
          ?.map((e) => Sources.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewsSourcesToJson(NewsSources instance) =>
    <String, dynamic>{
      'status': instance.status,
      'sources': instance.sources,
    };
