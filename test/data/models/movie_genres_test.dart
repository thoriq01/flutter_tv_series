import 'dart:convert';

import 'package:dicoding_tv_series/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final data = GenreModel(id: 1, name: "Thoriq");
  final Map<String, dynamic> jsonMap = json.decode(readJson('dummy_data/movie_genre.json'));

  test("Expect", () {
    expect(jsonMap, data.toJson());
  });

  test("Expect 2", () {
    final gnere = GenreModel.fromJson(jsonMap);
    expect(gnere.toEntity(), data.toEntity());
  });

  test("Props", () async {
    final gnere = GenreModel.fromJson(jsonMap);
    expect(gnere.id, data.id);
  });
  test("Props", () async {
    final gnere = GenreModel.fromJson(jsonMap);
    expect(gnere.props, [data.id, data.name]);
  });
}
