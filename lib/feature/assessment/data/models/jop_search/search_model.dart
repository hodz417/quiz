// feature/assessment/data/models/jop_search/search_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_model.freezed.dart';
part 'search_model.g.dart';

@freezed
class SearchResult with _$SearchResult {
  const factory SearchResult({
    required List<OrganicResult> organic,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}

@freezed
class OrganicResult with _$OrganicResult {
  const factory OrganicResult({
    required String title,
    required String link,
  }) = _OrganicResult;

  factory OrganicResult.fromJson(Map<String, dynamic> json) =>
      _$OrganicResultFromJson(json);
}