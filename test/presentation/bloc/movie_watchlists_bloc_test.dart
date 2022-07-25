import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/common/failure.dart';
import 'package:dicoding_tv_series/domain/usecase/watchlist_movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

class _WathclistMock extends Mock implements WatchListsMovie {}

void main() {
  late _WathclistMock _wathclistMock;
  late MockMovieRepository _movieRepository;
  late WatchListsMovie _watchListsMovie;
  setUp(() {
    _wathclistMock = _WathclistMock();
    _movieRepository = MockMovieRepository();
    _watchListsMovie = WatchListsMovie(_movieRepository);
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
  final message = "Sukses";
  blocTest<MovieWathclistBloc, MovieWathclistState>(
    "Test Save Bloc Watchlist",
    build: () {
      when(_watchListsMovie.saveWatchlist(testMovieDetail)).thenAnswer((_) async => Right(message));
      return MovieWathclistBloc(_watchListsMovie);
    },
    act: (bloc) {
      bloc.add(AddMovieWatchlist(testMovieDetail));
    },
    expect: () => [
      isA<MovieWathclistInitial>(),
      isA<MovieWatchlistLoading>(),
      isA<MovieWatchlistSuccessAdd>(),
      isA<MovieWatchlistIsAdded>(),
    ],
  );
  blocTest<MovieWathclistBloc, MovieWathclistState>(
    "Test Error Save Bloc Watchlist",
    build: () {
      when(_watchListsMovie.saveWatchlist(testMovieDetail)).thenAnswer((_) async => Left(DatabaseFailure(error)));
      return MovieWathclistBloc(_watchListsMovie);
    },
    act: (bloc) {
      bloc.add(AddMovieWatchlist(testMovieDetail));
    },
    expect: () => [
      isA<MovieWathclistInitial>(),
      isA<MovieWatchlistLoading>(),
      isA<MovieWatchlistError>(),
    ],
  );
  blocTest<MovieWathclistBloc, MovieWathclistState>(
    "Test Delete Save Bloc Watchlist",
    build: () {
      when(_watchListsMovie.deleteWatchlist(testMovieDetail)).thenAnswer((_) async => Right(message));
      return MovieWathclistBloc(_watchListsMovie);
    },
    act: (bloc) {
      bloc.add(RemoveMovieWatchlist(testMovieDetail));
    },
    expect: () => [
      isA<MovieWatchlistLoading>(),
      isA<MovieWatchlistSuccessRemoved>(),
      isA<MovieWatchlistIsNotAdded>(),
    ],
  );
  blocTest<MovieWathclistBloc, MovieWathclistState>(
    "Test Delete  Bloc Watchlist",
    build: () {
      when(_watchListsMovie.deleteWatchlist(testMovieDetail)).thenAnswer((_) async => Left(DatabaseFailure(error)));
      return MovieWathclistBloc(_watchListsMovie);
    },
    act: (bloc) {
      bloc.add(RemoveMovieWatchlist(testMovieDetail));
    },
    expect: () => [
      isA<MovieWatchlistLoading>(),
      isA<MovieWatchlistError>(),
    ],
  );
  blocTest<MovieWathclistBloc, MovieWathclistState>(
    "Test Delete  Bloc Watchlist",
    build: () {
      when(_watchListsMovie.getData()).thenAnswer((_) async => Right(testMovieList));
      return MovieWathclistBloc(_watchListsMovie);
    },
    act: (bloc) {
      bloc.add(LoadMovieWatchlist());
    },
    expect: () => [
      isA<MovieWatchlistLoading>(),
      isA<MovieWatchlistLoaded>(),
    ],
  );
  blocTest<MovieWathclistBloc, MovieWathclistState>(
    "Test Delete  Bloc Watchlist",
    build: () {
      when(_watchListsMovie.getData()).thenAnswer((_) async => Left(ServerFailure(message)));
      return MovieWathclistBloc(_watchListsMovie);
    },
    act: (bloc) {
      bloc.add(LoadMovieWatchlist());
    },
    expect: () => [
      isA<MovieWatchlistLoading>(),
      isA<MovieWatchlistError>(),
    ],
  );
  blocTest<MovieWathclistBloc, MovieWathclistState>(
    "Test Check is add moviewatchlist Bloc",
    build: () {
      when(_watchListsMovie.isAddWatchlist(12)).thenAnswer((_) async => true);
      return MovieWathclistBloc(_watchListsMovie);
    },
    act: (bloc) {
      bloc.add(CheckIsAddedMovieWatchlist(12));
    },
    expect: () => [
      isA<MovieWatchlistIsAdded>(),
    ],
  );
  blocTest<MovieWathclistBloc, MovieWathclistState>(
    "Test Check is add moviewatchlist Bloc",
    build: () {
      when(_watchListsMovie.isAddWatchlist(12)).thenAnswer((_) async => false);
      return MovieWathclistBloc(_watchListsMovie);
    },
    act: (bloc) {
      bloc.add(CheckIsAddedMovieWatchlist(12));
    },
    expect: () => [
      isA<MovieWatchlistIsNotAdded>(),
    ],
  );
  blocTest<MovieWathclistBloc, MovieWathclistState>(
    "Test Delete MovieWatchlist Bloc",
    build: () {
      when(_watchListsMovie.deleteWatchlist(testMovieDetail)).thenAnswer((_) async => Right(message));
      return MovieWathclistBloc(_watchListsMovie);
    },
    act: (bloc) {
      bloc.add(DeleteMovieWatchlist(testMovieDetail));
    },
    expect: () => [
      isA<MovieWatchlistLoading>(),
      isA<MovieWatchlistSuccessRemoved>(),
    ],
  );
  blocTest<MovieWathclistBloc, MovieWathclistState>(
    "Test Delete MovieWatchlist Bloc",
    build: () {
      when(_watchListsMovie.deleteWatchlist(testMovieDetail)).thenAnswer((_) async => Left(DatabaseFailure(error)));
      return MovieWathclistBloc(_watchListsMovie);
    },
    act: (bloc) {
      bloc.add(DeleteMovieWatchlist(testMovieDetail));
    },
    expect: () => [
      isA<MovieWatchlistLoading>(),
      isA<MovieWatchlistError>(),
    ],
  );
  test("Test event load", () {
    final event = LoadMovieWatchlist();
    expect(event.props, []);
  });
  test("Test event add", () {
    final event = AddMovieWatchlist(testMovieDetail);
    expect(event.movie, testMovieDetail);
  });
  test("Test event add", () {
    final event = AddMovieWatchlist(testMovieDetail);
    expect(event.props, [testMovieDetail]);
  });

  test("Test event remove", () {
    final event = RemoveMovieWatchlist(testMovieDetail);
    expect(event.movie, testMovieDetail);
  });
  test("Test event remove", () {
    final event = RemoveMovieWatchlist(testMovieDetail);
    expect(event.props, [testMovieDetail]);
  });
  test("Test event delete moviewatchlist", () {
    final event = DeleteMovieWatchlist(testMovieDetail);
    expect(event.movie, testMovieDetail);
  });
  test("Test event delete moviewatchlist", () {
    final event = DeleteMovieWatchlist(testMovieDetail);
    expect(event.props, [testMovieDetail]);
  });
  test("Test check event if movie added", () {
    final event = CheckIsAddedMovieWatchlist(1);
    expect(event.id, 1);
    expect(event.props, [1]);
  });
}
