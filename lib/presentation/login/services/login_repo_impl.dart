import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:hostel_management_pro/domain/core/base/consts/api_cons.dart';

import '../../../infrastructure/dal/services/dio_client.dart';
import 'login_repo.dart';

class LoginRepoImpl extends LoginRepo {
  final DioClient _dioClient;
  LoginRepoImpl(this._dioClient);

  @override
  Future<Either<String, Map<String, dynamic>>> doOwnerLogin(params1) async {
    try {
      final result = await _dioClient.requestForHostel(
        ApiConst.ownerLogin,
        'POST',
        params: params1,
      );

      return result.fold(
        (response) {
          if (response.data is Map<String, dynamic>) {
            return Right(response.data);
          } else if (response.data is String) {
            try {
              final decoded = jsonDecode(response.data);
              if (decoded is Map<String, dynamic>) {
                return Right(decoded);
              }
              return Left('Invalid response format');
            } catch (e) {
              return Left(response.data.toString());
            }
          } else {
            return Left('Unexpected response type');
          }
        },
        (error) => Left(error.toString()),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
}
