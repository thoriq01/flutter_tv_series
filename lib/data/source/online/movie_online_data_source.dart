import 'dart:convert';

import 'package:dicoding_tv_series/common/constant.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/data/models/movie_cast.dart';
import 'package:dicoding_tv_series/data/models/movie_model.dart';
import 'package:dicoding_tv_series/data/models/movie_detail_model.dart';
import 'package:dicoding_tv_series/data/models/movie_response.dart';
import 'package:http/http.dart' as http;

abstract class MovideDataRepository {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailResponse> getDetailMovies(int id);
  Future<List<MovieModel>> getRecomendationsMovies(int id);
  Future<List<MovieModel>> searchMovies(String query);
  Future<List<MovieCast>> getMovieCast(int id);
}

class MovieDataSource implements MovideDataRepository {
  final http.Client client;
  MovieDataSource({required this.client});

  @override
  Future<MovieDetailResponse> getDetailMovies(int id) async {
    final response = await client.get(Uri.parse("$BASE_URL/movie/$id?$API_KEY"));
    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await client.get(Uri.parse("$BASE_URL/movie/now_playing?$API_KEY"));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await client.get(Uri.parse("$BASE_URL/movie/popular?$API_KEY"));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getRecomendationsMovies(int id) async {
    final response = await client.get(Uri.parse("$BASE_URL/movie/$id/recommendations?$API_KEY"));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await client.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY'));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client.get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$query'));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieCast>> getMovieCast(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/movie/$id/credits?$API_KEY'));
    if (response.statusCode == 200) {
      return MovieCastResponse.fromJson(json.decode(response.body)).movieCast;
    } else {
      throw ServerException();
    }
  }
}
