import 'package:dicoding_tv_series/config/router/movie_router.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_cast_bloc/movie_cast_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_popular_bloc/movie_popular_bloc_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injector.dart' as dl;

void main() {
  dl.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviePopularBlocBloc>(
          create: (context) => dl.sl<MoviePopularBlocBloc>(),
        ),
        BlocProvider<MovieTopRatedBloc>(
          create: (context) => dl.sl<MovieTopRatedBloc>(),
        ),
        BlocProvider<MovieSearchBloc>(
          create: (context) => dl.sl<MovieSearchBloc>(),
        ),
        BlocProvider<MovieDetailBloc>(
          create: (context) => dl.sl<MovieDetailBloc>(),
        ),
        BlocProvider<MovieCastBloc>(
          create: (context) => dl.sl<MovieCastBloc>(),
        ),
        BlocProvider<MovieWathclistBloc>(
          create: (context) => dl.sl<MovieWathclistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'TV SERIES',
        onGenerateRoute: MovieRouter.movieRouterPage,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Color.fromRGBO(29, 39, 39, 0),
          appBarTheme: AppBarTheme(
            color: Color.fromRGBO(29, 39, 39, 0),
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
