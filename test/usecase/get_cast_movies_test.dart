import 'package:dartz/dartz.dart';
import 'package:dicoding_tv_series/domain/entities/cast.dart';
import 'package:dicoding_tv_series/domain/usecase/get_cast_movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetMovieCast getMovieCast;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getMovieCast = GetMovieCast(mockMovieRepository);
  });

  final int id = 1;
  final moviCast = <MovieCastEntities>[];

  test('should get movie detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getMovieCast(id)).thenAnswer((_) async => Right(moviCast));
    // act
    final result = await getMovieCast.execute(id);
    // assert
    expect(result, Right(moviCast));
  });
}
