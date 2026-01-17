import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../../config.dart';
import '../../../domain/core/base/consts/app_const.dart';
import '../../../domain/core/interfaces/base_model.dart';
import 'secure_storage_services.dart';

class DioClient {
  late Dio _dio;
  late Dio _authDio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ConfigEnvironments.getBaseURL()!,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},

        // 🔥 VERY IMPORTANT
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    _authDio = Dio(
      BaseOptions(
        baseUrl: ConfigEnvironments.getBaseURL()!,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 60),
        headers: {'Content-Type': 'application/json'},
        validateStatus: (status) => status != null && status < 500,
      ),
    );
  }

  /// Sets the Bearer token for authentication
  Future<void> _setAuthToken() async {
    String? token = await SecureStorageServices().readSecureData(key: TOKEN);
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  /// ------------------ NORMAL MODEL REQUEST ------------------
  Future<T?> request<T extends BaseModel>(
    String endpoint, {
    required String method,
    dynamic params,
    dynamic data,
    Map<String, dynamic>? headers,
    Options? options,
    required T Function(Map<String, dynamic>) fromJsonT,
  }) async {
    if (!await InternetConnection().hasInternetAccess) {
      throw Exception("No Internet Connection");
    }

    await _setAuthToken();

    try {
      Response response;

      switch (method.toUpperCase()) {
        case 'GET':
          response = await _dio.get(endpoint,
              queryParameters: params, options: options);
          break;
        case 'POST':
          response =
              await _dio.post(endpoint, data: params ?? data, options: options);
          break;
        case 'PUT':
          response = await _dio.put(endpoint, data: params);
          break;
        case 'DELETE':
          response = await _dio.delete(endpoint, data: params);
          break;
        default:
          throw Exception("Invalid HTTP Method");
      }

      return fromJsonT(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? "Request failed");
    } catch (e) {
      throw Exception("An unexpected error occurred");
    }
  }

  /// ------------------ RAW RESPONSE REQUEST ------------------
  Future<Either<Response, Exception>> requestForHostel(
    String url,
    String method, {
    params,
    Options? options,
  }) async {
    if (!await InternetConnection().hasInternetAccess) {
      return Right(Exception("No Internet Connection"));
    }

    try {
      Response response;

      if (method == 'POST') {
        response = await _dio.post(url, data: params);
      } else if (method == 'PUT') {
        response = await _dio.put(url, data: params);
      } else if (method == 'DELETE') {
        response = await _dio.delete(url);
      } else if (method == 'PATCH') {
        response = await _dio.patch(url, data: params);
      } else {
        response = await _dio.get(url, queryParameters: params);
      }

      // ✅ Always return response (even if status is 401,403,422...)
      return Left(response);
    } on DioException catch (e) {
      return Right(
        Exception(e.response?.data?['message'] ?? "Request failed"),
      );
    } on SocketException {
      return Right(Exception("No Internet Connection"));
    } on FormatException {
      return Right(Exception("Bad Response Format!"));
    } catch (e) {
      return Right(Exception("Something Went Wrong"));
    }
  }

  /// ------------------ AUTH REQUEST ------------------
  Future<Either<Response, Exception>> requestAuth(
    String url,
    String method, {
    dynamic params,
    String? token,
  }) async {
    if (!await InternetConnection().hasInternetAccess) {
      return Right(Exception("No Internet Connection"));
    }

    try {
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      Response response;

      if (method == 'POST') {
        response = await _authDio.post(url,
            data: params, options: Options(headers: headers));
      } else if (method == 'PUT') {
        response = await _authDio.put(url,
            data: params, options: Options(headers: headers));
      } else if (method == 'DELETE') {
        response = await _authDio.delete(url,
            options: Options(headers: headers));
      } else if (method == 'PATCH') {
        response = await _authDio.patch(url,
            data: params, options: Options(headers: headers));
      } else {
        response = await _authDio.get(url,
            queryParameters: params, options: Options(headers: headers));
      }

      return Left(response);
    } on DioException catch (e) {
      return Right(
        Exception(e.response?.data?['message'] ?? "Request failed"),
      );
    } catch (e) {
      return Right(Exception("Something Went Wrong"));
    }
  }
}
