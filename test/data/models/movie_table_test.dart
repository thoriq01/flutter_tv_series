import 'dart:convert';

import 'package:dicoding_tv_series/data/models/movie_table.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/entities/movie_detail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  var data = MovieTable(id: 1, title: "title", posterPath: "posterPath", overview: "overview");
  var map = MovieTable.fromMap(testMovieMap);

  test("Test Moive Table", () {
    expect(data, map);
  });

  test("From movie detail", () {
    var detail = MovieTable.fromEntity(MovieDetail(
      id: 1,
      title: "title",
      posterPath: "posterPath",
      overview: "overview",
      adult: false,
      backdropPath: '',
      genres: [],
      releaseDate: '',
      originalTitle: '',
      runtime: 2,
      voteAverage: 0,
      voteCount: 1,
    ));
    expect(data, detail);
  });

  test("To Json", () async {
    final Map<String, dynamic> jsonMap = json.decode(readJson('dummy_data/movie_table.json'));
    final json1 = data.toJson();
    expect(jsonMap, json1);
  });
  test("To Json", () async {
    expect(data.props, [data.id, data.title, data.posterPath, data.overview]);
  });

  test("description", () {
    final test = data.toEntity();

    expect(test, Movie.watchlist(id: 1, title: 'title', posterPath: 'posterPath', overview: 'overview'));
  });
}
