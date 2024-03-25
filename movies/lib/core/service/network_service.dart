import 'dart:io';
import 'package:dio/dio.dart';
import 'package:movies/core/constant/api_paths.dart';
import 'custom_response.dart';

final class ApiServiceOption {
  final ContentType? contentType;
  final ResponseType? responseType;

  const ApiServiceOption({this.contentType, this.responseType});

  @override
  String toString() {
    return 'content type is $contentType and response type is $responseType';
  }
}

class ApiService {
  late Dio _dio;

  ApiService() {
    _dio = Dio(BaseOptions(
        baseUrl: ApiPaths.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: 'application/json',
        responseType: ResponseType.json));
    // _dio.interceptors.add(CustomInterceptor(this));
    // _dio.interceptors.add(PrettyDioLogger(
    //   error: true,
    //   requestHeader: true,
    //   requestBody: true,
    // ));
  }

  Future<dynamic> getList(String path, {Map<String, dynamic>? query}) async {
    return _dio
        .get(path, queryParameters: query)
        .then((value) => value.data)
        .onError<DioException>(
          (error, stackTrace) => Future.error(error),
    );
  }
  Future<AppResponse> get(String path, {Map<String, dynamic>? query}) async {
    print(path);
    return _dio
        .get(path, queryParameters: query)
        .then((value) => value.data as AppResponse)
        .onError<DioException>(
          (error, stackTrace) => error.response!.data as ErrorResponse,
        );
  }

  Future<AppResponse> post(String path,
      {Map<String, dynamic>? query, Object? body}) async {
    return _dio
        .post(path, data: body, queryParameters: query)
        .then((value) => value.data as AppResponse)
        .onError<DioException>(
            (error, stackTrace) => error.response!.data as ErrorResponse);
  }

  Future<AppResponse> put(String path, {Object? body}) async {
    return _dio
        .put(path, data: body)
        .then((value) => value.data as AppResponse)
        .onError<DioException>((error, stackTrace) => error.response!.data as ErrorResponse);
  }
}
