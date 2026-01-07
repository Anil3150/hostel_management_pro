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
    _dio = Dio(BaseOptions(
      baseUrl: ConfigEnvironments.getBaseURL()!,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    _authDio = Dio(
      BaseOptions(
        baseUrl: 'https://securelandapi.hashstack.in/api/',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 60),
        headers: {'Content-Type': 'application/json'},
      )
    );
  }

  /// Sets the Bearer token for authentication
  Future<void> _setAuthToken() async {
    String? token = await SecureStorageServices().readSecureData(key: TOKEN);
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  // Future<String?> _refreshToken() async {
  // try {
  //   final refreshToken = await SecureStorageServices().readSecureData(key: 'refreshToken');
  //   if (refreshToken == null) return null;

  //   final response = await _authDio.post(
  //     'auth/refresh', // <-- adjust to your backend refresh endpoint
  //     data: {'refreshToken': refreshToken},
  //   );

  //   final newAccessToken = response.data['accessToken'];
  //   // Save new token
  //   await SecureStorageServices().writeSecureData(key: TOKEN, value: newAccessToken);

  //   return newAccessToken;
  // } catch (e) {
  //   return null; // refresh failed
  // }
  // }


  /// Generic API request method
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

    await _setAuthToken(); // Apply token

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

      return fromJsonT(response.data); // Parse JSON to Model
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? "Request failed");
    } catch (e) {
      throw Exception("An unexpected error occurred");
    }
  }

Future<Either<Response, Exception>> requestForSecureLand(
    String url,
    String method, {
    params,
    Options? options,
  }) async {
    Response response;

    if (!await InternetConnection().hasInternetAccess) {
      throw Exception("No Internet Connection");
    }

    try {
      if (method == 'POST') {
        print(params);
        print('POST URL: $url');
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

      if (response.statusCode == 200) {
        return Left(response);
      } else if (response.statusCode == 201) {
        return Left(response);
      } else if (response.statusCode == 403) {
        throw Right(Exception("Unauthorized"));
        
      } else if (response.statusCode == 500) {
        throw Right(Exception("Server Error"));
      } else {
        throw Right(Exception("Something Went Wrong"));
      }
    } on SocketException {
      throw Right(Exception("No Internet Connection"));
    } on FormatException {
      throw Right(Exception("Bad Response Format!"));
    } on DioException catch (e) {
      throw Right(Exception(e));
    } catch (e) {
      throw Right(Exception("Something Went Wrong"));
    }
  }

  // Future<Either<Response, Exception>> requestAuth(String url, String method, 
  //     {params,token}) async {
  //   Response response;

  //   if (!await InternetConnection().hasInternetAccess) {
  //     throw Exception("No Internet Connection");
  //   }

  //   try {
  //     if (method == 'POST') {
  //       response = await _authDio.post(url, data: params,options: Options(headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     }));
  //     } else if (method == 'PUT') {
  //       response = await _authDio.put(url, data: params,options: Options(headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     }));
  //     } else if (method == 'DELETE') {
  //       response = await _authDio.delete(url);
  //     } else if (method == 'PATCH') {
  //       response = await _authDio.patch(url, queryParameters: params,options: Options(headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     }));
  //     } else {
  //       response = await _authDio.get(
  //         url,
  //         queryParameters: params,
  //         options: Options(headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     })
  //       );
  //     }

      

  //     if (response.statusCode == 200) {
  //       return Left(response);
  //     } else if (response.statusCode == 401) {
  //       throw Right(Exception("Unauthorized"));
  //     } else if (response.statusCode == 403) {
  //        throw Right(Exception("Unauthorized")); 
  //     } else if (response.statusCode == 500) {
  //       throw Right(Exception("Server Error"));
  //     } else {
  //       throw Right(Exception("Something Went Wrong"));
  //     }
  //   } on SocketException {
  //     throw Right(Exception("No Internet Connection"));
  //   } on FormatException {
  //     throw Right(Exception("Bad Response Format!"));
  //   } on DioException catch (e) {
  //     throw Right(Exception(e));
  //   } catch (e) {
  //     throw Right(Exception("Something Went Wrong"));
  //   }
  // }

Future<Either<Response, Exception>> requestAuth(
  String url,
  String method, {
  dynamic params,
  String? token,
}) async {
  Response response;

  if (!await InternetConnection().hasInternetAccess) {
    return Right(Exception("No Internet Connection"));
  }

  try {
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    if (method == 'POST') {
      response = await _authDio.post(url, data: params, options: Options(headers: headers));
    } else if (method == 'PUT') {
      response = await _authDio.put(url, data: params, options: Options(headers: headers));
    } else if (method == 'DELETE') {
      response = await _authDio.delete(url, options: Options(headers: headers));
    } else if (method == 'PATCH') {
      response = await _authDio.patch(url, data: params, options: Options(headers: headers));
    } else {
      response = await _authDio.get(url, queryParameters: params, options: Options(headers: headers));
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Left(response);
    }

    else if (response.statusCode == 401 || response.statusCode == 403) {
      // 🔑 Force logout
      await SecureStorageServices().deleteSecureData(key: TOKEN);
      return Right(Exception("Session expired, please log in again."));
    }

    else if (response.statusCode == 500) {
      return Right(Exception("Server Error"));
    }

    return Right(Exception("Something Went Wrong"));
  } on SocketException {
    return Right(Exception("No Internet Connection"));
  } on FormatException {
    return Right(Exception("Bad Response Format!"));
  } on DioException catch (e) {
    return Right(Exception(e.message ?? "Request failed"));
  } catch (e) {
    return Right(Exception("Something Went Wrong"));
  }
}



}
