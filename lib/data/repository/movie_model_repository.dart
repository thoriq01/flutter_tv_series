import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/data/models/movie_table.dart';
import 'package:dicoding_tv_series/data/source/local/movie_local_source.dart';
import 'package:dicoding_tv_series/data/source/online/movie_online_data_source.dart';
import 'package:dicoding_tv_series/domain/entities/cast.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/entities/movie_detail.dart';
import 'package:dicoding_tv_series/domain/repositories/movie_repositorie.dart';

class MovieModelRepository implements MovieRepository {
  final MovieDataSource remoteDataSource;
  final MovieLocalSource localDataSource;

  MovieModelRepository(this.remoteDataSource, this.localDataSource);
  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    try {
      final result = await remoteDataSource.getNowPlayingMovies();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id) async {
    final response = await remoteDataSource.getDetailMovies(id);
    try {
      return Right(response.toEntity());
    } on ServerException {
      return Left(ServerFailure("Failed to load movie detail"));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id) async {
    final response = await remoteDataSource.getRecomendationsMovies(id);
    try {
      return Right(response.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    final response = await remoteDataSource.getPopularMovies();
    try {
      return Right(response.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    final response = await remoteDataSource.getTopRatedMovies();
    try {
      return Right(response.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getWatchlistMovies() async {
    final result = await localDataSource.getWatchlistMovies();
    return Right(result.map((model) => model.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getMovieById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(MovieDetail movie) async {
    final result = await localDataSource.removeWatchlist(MovieTable.fromEntity(movie));
    return Right(result);
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
    final response = await remoteDataSource.searchMovies(query);
    try {
      return Right(response.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<MovieCastEntities>>> getMovieCast(int id) async {
    final result = await remoteDataSource.getMovieCast(id);
    try {
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(MovieDetail movie) async {
    final result = await localDataSource.insertWatchlist(MovieTable.fromEntity(movie));
    return Right(result);
  }
}
