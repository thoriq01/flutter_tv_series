import 'package:dicoding_tv_series/data/models/movie_cast.dart';
import 'package:dicoding_tv_series/data/models/movie_model.dart';
import 'package:equatable/equatable.dart';

class MovieResponse extends Equatable {
  final List<MovieModel> movieList;

  MovieResponse({required this.movieList});

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        movieList: List<MovieModel>.from((json["results"] as List).map((x) => MovieModel.fromJson(x)).where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(movieList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [movieList];
}

class MovieCastResponse extends Equatable {
  final List<MovieCast> movieCast;

  MovieCastResponse({required this.movieCast});

  factory MovieCastResponse.fromJson(Map<String, dynamic> json) => MovieCastResponse(
        movieCast: List<MovieCast>.from((json["cast"] as List).map((x) => MovieCast.fromJson(x)).where((element) => element.profilePath != null)),
      );

  Map<String, dynamic> toJson() => {
        "cast": List<dynamic>.from(movieCast.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [movieCast];
}
