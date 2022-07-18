import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/repositories/movie_repositorie.dart';

class GetTopRatedMovie {
  final MovieRepository _repository;

  GetTopRatedMovie(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getTopRatedMovies();
  }
}
