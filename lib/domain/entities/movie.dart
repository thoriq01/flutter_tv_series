import 'package:dicoding_tv_series/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  Movie.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
  });
  factory Movie.fromEntity(MovieDetail movie) => Movie(
        adult: movie.adult,
        backdropPath: movie.backdropPath,
        genreIds: [],
        id: movie.id,
        originalTitle: movie.originalTitle,
        overview: movie.overview,
        posterPath: movie.posterPath,
        releaseDate: movie.releaseDate,
        title: movie.title,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
        popularity: 60.441,
        video: false,
      );
  movie() {
    return MovieDetail(
      adult: false,
      backdropPath: backdropPath,
      genres: [],
      id: id,
      originalTitle: "",
      overview: overview!,
      posterPath: posterPath!,
      releaseDate: "",
      runtime: 0,
      title: title!,
      voteAverage: 0,
      voteCount: 0,
    );
  }

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int id;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
      ];
}
