import 'package:dartz/dartz.dart';

abstract class SignupRepo {
   Future<Either<String ,Map<String, dynamic>>> doOwnerSignup(params1);
   Future<Either<String ,Map<String, dynamic>>> doStudentSignup(params1);
}