import 'package:dio/dio.dart';
import 'package:edufy_mobile/src/core/network/api_client.dart';
import 'package:edufy_mobile/src/core/network/exception/api_exception.dart';
import 'package:edufy_mobile/src/shared/types/api_result.dart';

abstract class BaseRepository {
  final ApiClient dio;
  BaseRepository({required this.dio});

  Future<ApiResult<T, ApiException>> post<T>({
    required String endpoint,
    Object? data,
    required T Function(Map<String, dynamic>) fromMap,
    Options? options,
  }) async {
    try {
      final response = await dio.post(endpoint, data: data, options: options);
      return ApiResult(response: fromMap(response.data));
    } on DioException catch (e) {
      return ApiResult(exception: ApiException.fromDioError(e));
    }
  }

  Future<ApiResult<T, ApiException>> put<T>({
    required String endpoint,
    Object? data,
    required T Function(Map<String, dynamic>) fromMap,
    Options? options,
  }) async {
    try {
      final response = await dio.put(endpoint, data: data, options: options);
      return ApiResult(response: fromMap(response.data));
    } on DioException catch (e) {
      return ApiResult(exception: ApiException.fromDioError(e));
    }
  }

  Future<ApiResult<T, ApiException>> get<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromMap,
    Map<String, dynamic>? parameters,
    Options? options,
  }) async {
    try {
      final response = await dio.get(endpoint, queryParameters: parameters, options: options);
      return ApiResult(response: fromMap(response.data));
    } on DioException catch (e) {
      return ApiResult(exception: ApiException.fromDioError(e));
    }
  }

  Future<ApiResult<T, ApiException>> delete<T>({
    required String endpoint,
    required T Function(Map<String, dynamic>) fromMap,
    Map<String, dynamic>? parameters,
    Object? data,
    Options? options,
  }) async {
    try {
      final res = await dio.delete(
        endpoint,
        queryParameters: parameters,
        data: data,
        options: options,
      );

      // Nếu ApiClient trả về Response -> lấy res.data, nếu trả về Map -> dùng thẳng
      final dynamic raw = (res is Response) ? res.data : res;

      // Chuẩn hóa về Map<String, dynamic>
      final Map<String, dynamic> json = raw is Map<String, dynamic>
          ? raw
          : raw is Map
          ? Map<String, dynamic>.from(raw)
          : raw == null
          ? <String, dynamic>{}
          : <String, dynamic>{'data': raw};

      return ApiResult(response: fromMap(json));
    } on DioException catch (e) {
      return ApiResult(exception: ApiException.fromDioError(e));
    }
  }
}
