import 'package:flutter_test/flutter_test.dart';

import 'data/test_movie_local_source_test.dart' as testMovieLocalSource;
import 'data/test_movie_online_source_test.dart' as testMovieOnlineSource;
import 'usecase/get_popular_movies.dart' as getPopularMoviesUsecase;
import 'usecase/get_top_rated_movies_test.dart' as getRatedMoviesUsecase;
import 'usecase/get_cast_movies_test.dart' as getCastMoviesUsecase;
import 'usecase/search_movies_test.dart' as searchMoviesUsecase;
import 'usecase/watchlist_movies_test.dart' as watchlistMoviesUsecase;

void main() {
  group("Test return data source", () {
    testMovieLocalSource.main();
    testMovieOnlineSource.main();
  });
  group("test  return usecase", () {
    getPopularMoviesUsecase.main();
    getRatedMoviesUsecase.main();
    getCastMoviesUsecase.main();
    searchMoviesUsecase.main();
    watchlistMoviesUsecase.main();
  });
}
