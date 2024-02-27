import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:movieapp/util/strings.dart';
import 'package:path_provider/path_provider.dart' as pp;

class Request {
  final Dio _dio = Dio();
  Request() {
    updateDioInterceptors();
  }

  void updateAuthorization(String token) {
    _dio.options.headers['authorization'] = token;
  }

  void updateDioInterceptors() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      validateStatus: (value) {
        return value! <= 500;
      },
      headers: {
        'Accept': 'application/json',
      },
    );
    _dio
      ..interceptors.add(
        LogInterceptor(
          requestBody: kDebugMode ? true : false,
          responseBody: kDebugMode ? true : false,
          requestHeader: kDebugMode ? true : false,
        ),
      )
      ..interceptors.add(
        InterceptorsWrapper(
          onError: (DioException e, handler) {
            return handler.next(e);
          },
        ),
      )
      ..interceptors.add(
        DioCacheInterceptor(
          options: CacheOptions(
            store: HiveCacheStore(AppPathProvider.path),
            policy: CachePolicy.refreshForceCache,
            hitCacheOnErrorExcept: [],
            maxStale: const Duration(
              days: 7,
            ),
            priority: CachePriority.high,
          ),
        ),
      );

    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final HttpClient client =
            HttpClient(context: SecurityContext(withTrustedRoots: false));
        client.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return client;
      },
    );
  }

  // requests
  Future<Response> get(String path, Map<String, dynamic> query) async {
    return await _dio.get(path, queryParameters: query);
  }

  Future<Response> post(String path, {Object? data}) async {
    return await _dio.post(path, data: data);
  }
}

class AppPathProvider {
  AppPathProvider._();

  static String? _path;

  static String get path {
    if (_path != null) {
      return _path!;
    } else {
      throw Exception('path not initialized');
    }
  }

  static Future<void> initPath() async {
    final dir = await pp.getApplicationDocumentsDirectory();
    _path = dir.path;
  }
}
