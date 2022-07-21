import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/domain/usecase/search_movie.dart';
import 'package:dicoding_tv_series/domain/usecase/watchlist_movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late WatchListsMovie watchListsMovie;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    watchListsMovie = WatchListsMovie(mockMovieRepository);
  });
  final tMovies = <Movie>[];
  final String remove = "Remove from Watchlist";
  test('should get list movies', () async {
    // arrange
    when(mockMovieRepository.getWatchlistMovies()).thenAnswer((_) async => Right(tMovies));
    // act
    final result = await watchListsMovie.getData();
    // assert
    expect(result, Right(tMovies));
  });

  test("should add movies to watchlist", () async {
    when(mockMovieRepository.saveWatchlist(testMovieDetail)).thenAnswer((_) async => Right("Added to Watchlist"));
    final result = await watchListsMovie.saveWatchlist(testMovieDetail);
    expect(result, Right("Added to Watchlist"));
  });

  test("should remove movies to watchlist", () async {
    when(mockMovieRepository.removeWatchlist(testMovieDetail)).thenAnswer((_) async => Right(remove));
    final result = await watchListsMovie.deleteWatchlist(testMovieDetail);
    expect(result, Right(remove));
  });

  
}
