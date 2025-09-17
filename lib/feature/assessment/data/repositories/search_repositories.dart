// feature/assessment/data/repositories/search_repository.dart
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:quiz/core/config/config.dart';
import 'package:quiz/feature/assessment/data/models/jop_search/search_model.dart';

class SearchRepository {
  final Dio _dio;

  SearchRepository({Dio? dio}) : _dio = dio ?? Dio(BaseOptions(baseUrl: AppConfig.baseUrl));

  Future<Either<String, List<OrganicResult>>> searchQuery(String query) async {
    try {
      final response = await _dio.post(
        '/search',
        data: {
          'q': query,
          'hl': 'ar',
        },
        options: Options(headers: {
          'X-API-KEY': AppConfig.serperApiKey,
          'Content-Type': 'application/json',
        }),
      );

      final searchResult = SearchResult.fromJson(response.data);
      final results = searchResult.organic.take(3).toList();

      return Right(results);
    } on DioException catch (e) {
      return Left(e.response?.data?['message'] ?? 'An error occurred');
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }
}