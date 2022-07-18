import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/entities/movie_detail.dart';
import 'package:dicoding_tv_series/domain/repositories/movie_repositorie.dart';

class WatchListsMovie {
  final MovieRepository _repository;

  WatchListsMovie(this._repository);

  Future<Either<Failure, List<Movie>>> getData() {
    return _repository.getWatchlistMovies();
  }

  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie) {
    return _repository.saveWatchlist(movie);
  }

  Future<Either<Failure, String>> deleteWatchlist(MovieDetail movie) {
    return _repository.removeWatchlist(movie);
  }

  Future<bool> isAddWatchlist(int id) {
    return _repository.isAddedToWatchlist(id);
  }
}
