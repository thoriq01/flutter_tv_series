import 'package:flutter_test/flutter_test.dart';

import 'data/test_movie_local_source_test.dart' as testMovieLocalSource;
import 'data/test_movie_online_source_test.dart' as testMovieOnlineSource;
import 'usecase/get_popular_movies.dart' as getPopularMoviesUsecase;
import 'usecase/get_top_rated_movies_test.dart' as getRatedMoviesUsecase;
import 'usecase/get_cast_movies_test.dart' as getCastMoviesUsecase;
import 'usecase/search_movies_test.dart' as searchMoviesUsecase;
import 'usecase/watchlist_movies_test.dart' as watchlistMoviesUsecase;
import 'presentation/bloc/popular_movies_bloc_test.dart' as popularMoviesBloc;
import 'presentation/bloc/top_rated_movies_bloc_test.dart' as topRatedMoviesBloc;
// import 'presentation/bloc/detail_movies.bloc.dart' as detailMoviesBloc;
import 'presentation/bloc/detail_movies.bloc_test.dart' as detailMoviesBloc;
import 'presentation/bloc/watchlist_movies_bloc_test.dart' as watchlistMoviesBloc;
import 'presentation/pages/detail_movies_pages_test.dart' as detailMoviesPages;
import 'presentation/pages/category_list_movies_test.dart' as categoryListMovies;

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
  group("bloc unit test", () {
    popularMoviesBloc.main();
    topRatedMoviesBloc.main();
    detailMoviesBloc.main();
    watchlistMoviesBloc.main();
  });

  group("Presentation based bloc", () {
    detailMoviesPages.main();
    // listMoviesPages.main();
    categoryListMovies.main();
  });
}
