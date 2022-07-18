import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/entities/movie_detail.dart';
import 'package:dicoding_tv_series/domain/repositories/movie_repositorie.dart';

class GetDetailMovie {
  final MovieRepository _repository;

  GetDetailMovie(this._repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return _repository.getMovieDetail(id);
  }
}
