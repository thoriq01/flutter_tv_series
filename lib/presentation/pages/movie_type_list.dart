import 'package:dicoding_tv_series/presentation/bloc/movie_popular_bloc/movie_popular_bloc_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieTypeListPage extends StatefulWidget {
  final String category;
  const MovieTypeListPage({Key? key, required this.category}) : super(key: key);

  @override
  _MovieTypeListPageState createState() => _MovieTypeListPageState();
}

class _MovieTypeListPageState extends State<MovieTypeListPage> {
  @override
  void initState() {
    super.initState();
    if (this.widget.category == "popular") {
      context.read<MoviePopularBlocBloc>().add(LoadPopularMovie());
    } else if (this.widget.category == "topmovie") {
      context.read<MovieTopRatedBloc>().add(LoadMovieTopRated());
    } else {
      context.read<MovieWathclistBloc>().add(LoadMovieWatchlist());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: _appBarTitle(),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Builder(builder: (context) {
            if (this.widget.category == "topmovie") {
              return BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(builder: (context, state) {
                if (state is MovieTopRatedLoaded) {
                  return MovieListCard(
                    length: state.movies.length,
                    isWatchlist: false,
                    height: double.infinity,
                    movies: state.movies,
                    direction: Axis.vertical,
                  );
                } else if (state is MovieTopRatedError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              });
            } else if (this.widget.category == "popular") {
              return BlocBuilder<MoviePopularBlocBloc, MoviePopularBlocState>(builder: (context, state) {
                if (state is MoviePopularLoaded) {
                  return MovieListCard(
                    length: state.movies.length,
                    height: MediaQuery.of(context).size.width * 100,
                    isWatchlist: false,
                    movies: state.movies,
                    direction: Axis.vertical,
                  );
                } else if (state is MoviePopularError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              });
            } else {
              return BlocBuilder<MovieWathclistBloc, MovieWathclistState>(
                builder: (context, state) {
                  if (state is MovieWatchlistLoading) {
                    return CircularProgressIndicator();
                  } else if (state is MovieWatchlistError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else if (state is MovieWatchlistLoaded) {
                    if (state.movies.length > 0) {
                      return Container(
                        child: MovieListCard(
                          length: state.movies.length,
                          isWatchlist: false,
                          height: MediaQuery.of(context).size.height,
                          movies: state.movies,
                          direction: Axis.vertical,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              );
            }
          }),
        ),
      ),
    );
  }

  _appBarTitle() {
    if (this.widget.category == "topmovie") {
      return Text(
        "Top Rated",
        style: TextStyle(fontSize: 20, color: Colors.white),
      );
    } else if (this.widget.category == "popular") {
      return Text(
        "Popular",
        style: TextStyle(fontSize: 20, color: Colors.white),
      );
    } else {
      return Text(
        "Watchlist",
        style: TextStyle(fontSize: 20, color: Colors.white),
      );
    }
  }
}
