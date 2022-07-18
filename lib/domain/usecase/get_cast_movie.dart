import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/entities/cast.dart';
import 'package:dicoding_tv_series/domain/repositories/movie_repositorie.dart';

class GetMovieCast {
  final MovieRepository _repository;

  GetMovieCast(this._repository);

  Future<Either<Failure, List<MovieCastEntities>>> execute(int movieId) async {
    return _repository.getMovieCast(movieId);
  }
}
