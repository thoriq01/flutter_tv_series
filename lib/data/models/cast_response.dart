import 'package:dicoding_tv_series/data/models/movie_model.dart';
import 'package:equatable/equatable.dart';

class CastResponse extends Equatable {
  final List<MovieModel> movieList;

  CastResponse({required this.movieList});

  factory CastResponse.fromJson(Map<String, dynamic> json) => CastResponse(
        movieList: List<MovieModel>.from((json["cast"] as List).map((x) => MovieModel.fromJson(x)).where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(movieList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [movieList];
}
