import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/data/source/local/movie_local_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late MovieLocalSource movieLocalSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    movieLocalSource = MovieLocalSource(mockDatabaseHelper);
  });

  group('save watchlist', () {
    test("Should return success message when insert watchlist", () async {
      when(mockDatabaseHelper.insertWatchlist(testMovieTable)).thenAnswer((_) async => 1);

      final result = await movieLocalSource.insertWatchlist(testMovieTable);
      expect(result, "Added to Watchlist");
    });

    test('should throw DatabaseException when insert to database is failed', () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable)).thenThrow(Exception());
      // act
      final call = movieLocalSource.insertWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test("Should return success message when remove watchlist", () async {
      when(mockDatabaseHelper.removeWatchlist(testMovieTable)).thenAnswer((_) async => 1);

      final result = await movieLocalSource.removeWatchlist(testMovieTable);
      expect(result, "Removed from Watchlist");
    });

    test('should throw DatabaseException when remove from database is failed', () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable)).thenThrow(Exception());
      // act
      final call = movieLocalSource.removeWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail By Id', () {
    final tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tId)).thenAnswer((_) async => testMovieMap);
      // act
      final result = await movieLocalSource.getMovieById(tId);
      // assert
      expect(result, testMovieTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await movieLocalSource.getMovieById(tId);
      // assert
      expect(result, null);
    });
  });
  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies()).thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await movieLocalSource.getWatchlistMovies();
      // assert
      expect(result, [testMovieTable]);
    });
  });
}
