import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/repositories/movie_repositorie.dart';

class SearchMovie {
  final MovieRepository _repository;

  SearchMovie(this._repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return _repository.searchMovies(query);
  }
}
