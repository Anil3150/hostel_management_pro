import 'package:dartz/dartz.dart';

abstract class LoginRepo {
  Future<Either<String, Map<String, dynamic>>> doOwnerLogin(dynamic params1);
}
