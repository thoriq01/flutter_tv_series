import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/usecase/watchlist_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';

class _WathclistMock extends Mock implements WatchListsMovie {}

void main() {
  late _WathclistMock _wathclistMock;

  setUp(() {
    _wathclistMock = _WathclistMock();
  });

  final succes = "Success";
  final error = "Error";
  final int id = 1;
  group("Save wathclist", () {
    // Thoriq
    test("Should return message when success insert to local database", () async* {
      when(_wathclistMock.saveWatchlist(testMovieDetail)).thenAnswer((_) async => Right(succes));

      final bloc = MovieWathclistBloc(_wathclistMock)..add(AddMovieWatchlist(testMovieDetail));

      expect(bloc, emitsInOrder([MovieWatchlistIsAdded()]));
    });
    test("Should return message when error insert to local database", () async* {
      when(_wathclistMock.saveWatchlist(testMovieDetail)).thenAnswer((_) async => Left(DatabaseFailure(error)));

      final bloc = MovieWathclistBloc(_wathclistMock)..add(AddMovieWatchlist(testMovieDetail));

      expect(bloc, emitsInOrder([MovieWatchlistError(error)]));
    });
  });
  group("Delete wathclist", () {
    // Thoriq
    test("Should return message when success insert to local database", () async* {
      when(_wathclistMock.deleteWatchlist(testMovieDetail)).thenAnswer((_) async => Right(succes));

      final bloc = MovieWathclistBloc(_wathclistMock)..add(DeleteMovieWatchlist(testMovieDetail));

      expect(bloc, emitsInOrder([MovieWatchlistSuccessRemoved(succes)]));
    });
    test("Should return message when error insert to local database", () async* {
      when(_wathclistMock.deleteWatchlist(testMovieDetail)).thenAnswer((_) async => Left(DatabaseFailure(error)));

      final bloc = MovieWathclistBloc(_wathclistMock)..add(DeleteMovieWatchlist(testMovieDetail));

      expect(bloc, emitsInOrder([MovieWatchlistError(error)]));
    });
  });
  group("Check if is added to wathclist", () {
    // Thoriq
    test("Should return message when success insert to local database", () async* {
      when(_wathclistMock.isAddWatchlist(id)).thenAnswer((_) async => true);

      final bloc = MovieWathclistBloc(_wathclistMock)..add(AddMovieWatchlist(testMovieDetail));

      expect(bloc, emitsInOrder([MovieWatchlistIsAdded()]));
    });
    test("Should return message when error insert to local database", () async* {
      when(_wathclistMock.isAddWatchlist(id)).thenAnswer((_) async => false);

      final bloc = MovieWathclistBloc(_wathclistMock)..add(AddMovieWatchlist(testMovieDetail));

      expect(bloc, emitsInOrder([MovieWatchlistIsNotAdded()]));
    });
  });
}
