import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/repositories/movie_repositorie.dart';

class GetRecomendation {
  final MovieRepository repository;

  GetRecomendation(this.repository);

  Future<Either<Failure, List<Movie>>> execute(int id) {
    return repository.getMovieRecommendations(id);
  }
}
