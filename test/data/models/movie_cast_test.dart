import 'dart:convert';

import 'package:dicoding_tv_series/data/models/movie_cast.dart';
import 'package:dicoding_tv_series/data/models/movie_response.dart';
import 'package:dicoding_tv_series/domain/entities/cast.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final movieCast = MovieCast(
    adult: false,
    gender: 1,
    id: 40036,
    knownForDepartment: "Acting",
    name: "Taraji P. Henson",
    originalName: "Taraji P. Henson",
    popularity: 13.079,
    profilePath: "/rxnEvzGlRBsE94s7lC4cMAiLluH.jpg",
    castId: 9,
    character: "Belle Bottom (voice)",
    creditId: "5e3ae8c6ac8e6b0011ca3150",
    order: 4,
  );

  final listCast = MovieCastResponse(
    movieCast: [movieCast],
  );

  test("Should return list cast model", () async {
    final Map<String, dynamic> jsonMap = json.decode(readJson('dummy_data/movie_cast.json'));
    final result = MovieCastResponse.fromJson(jsonMap);

    expect(result, listCast);
  });

  test("To json", () async {
    final result = listCast.toJson();
    final expectedJson = {
      'cast': [
        {
          "adult": false,
          "gender": 1,
          "id": 40036,
          "known_for_department": "Acting",
          "name": "Taraji P. Henson",
          "original_name": "Taraji P. Henson",
          "popularity": 13.079,
          "profile_path": "/rxnEvzGlRBsE94s7lC4cMAiLluH.jpg",
          "cast_id": 9,
          "character": "Belle Bottom (voice)",
          "credit_id": "5e3ae8c6ac8e6b0011ca3150",
          "order": 4
        }
      ],
    };
    expect(result, expectedJson);
  });

  test("", () async {
    final data = movieCast.toEntity();
    final entities = MovieCastEntities(
      false,
      1,
      40036,
      "Acting",
      "Taraji P. Henson",
      "Taraji P. Henson",
      13.079,
      "/rxnEvzGlRBsE94s7lC4cMAiLluH.jpg",
    );
    expect(entities, data);
  });
}
