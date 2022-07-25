import 'dart:convert';

import 'package:dicoding_tv_series/data/models/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final data = MovieDetailResponse(
    adult: false,
    backdropPath: "/path.jpg",
    genres: [],
    id: 1,
    originalTitle: 'Original Title',
    overview: 'Overview',
    posterPath: '/path.jpg',
    releaseDate: '2020-05-05',
    runtime: 120,
    title: 'Title',
    voteAverage: 1.0,
    voteCount: 1,
    budget: 100,
    homepage: "https://google.com",
    imdbId: "imdb1",
    originalLanguage: "en",
    popularity: 1.0,
    revenue: 12000,
    status: "Status",
    tagline: 'Tagline',
    video: false,
  );

  test("", () async {
    final result = data.toEntity();
    expect(result.adult, data.adult);
  });

  test("to json", () async {
    final result = data.toJson();
    final Map<String, dynamic> jsonMap = json.decode(readJson('dummy_data/movie_detail.json'));
    expect(result, jsonMap);
  });
}
