import 'package:dartz/dartz.dart';
import 'package:weather_app/core/use_case/failure.dart';

abstract class UseCaseBase<T1, T2> {
  Future<Either<Failure, T1>> call(T2 params);
}
