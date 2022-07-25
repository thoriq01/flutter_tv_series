import 'dart:io';

import 'package:dicoding_tv_series/presentation/widget/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  setUpAll(() {
    HttpOverrides.global = null;
  });

  testWidgets("entah", (tester) async {
    final test = MovieCard(
      title: "Mejiku",
      posterPath: "https://image.tmdb.org/t/p/w500/poster_path",
      date: "2022-12-12",
      overview: "Mejiku is a story of two people who must fight to save their lives.",
      isWatchlist: false,
    );

    await tester.runAsync(() async {
      final httpData = HttpClient();
      final request = httpData.getUrl(Uri.parse("https://image.tmdb.org/t/p/w500/poster_path"));
    });
    await tester.pumpWidget(
      MaterialApp(
        home: test,
      ),
    );
    expect(find.byType(Container), findsWidgets);
  });
  testWidgets("entah", (tester) async {
    final test = MovieCard(
      title: "Mejiku",
      posterPath: "https://image.tmdb.org/t/p/w500/poster_path",
      date: "2022-12-12",
      overview: "Mejiku is a story of two people who must fight to save their lives.",
      isWatchlist: true,
    );

    await tester.runAsync(() async {
      final httpData = HttpClient();
      final request = httpData.getUrl(Uri.parse("https://image.tmdb.org/t/p/w500/poster_path"));
    });
    await tester.pumpWidget(
      MaterialApp(
        home: test,
      ),
    );
    expect(find.byType(Container), findsWidgets);
  });
}
