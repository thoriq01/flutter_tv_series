import 'package:dicoding_tv_series/config/router/movie_route_name.dart';
import 'package:dicoding_tv_series/config/router/movie_router.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_list.dart';
import 'package:dicoding_tv_series/presentation/widget/title_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieWatchlistWidget extends StatelessWidget {
  const MovieWatchlistWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieWathclistBloc, MovieWathclistState>(
      builder: (context, state) {
        if (state is MovieWatchlistLoading) {
          return Container();
        } else if (state is MovieWatchlistError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is MovieWatchlistLoaded) {
          if (state.movies.length > 0) {
            return Container(
              child: Column(
                children: [
                  TitleContent(
                    text: "Watchlist",
                    onPressed: () {
                      Navigator.pushNamed(context, movieTypeListPage, arguments: ListTypeMovieArgument("watchlist"));
                    },
                  ),
                  MovieListCard(
                    length: state.movies.length,
                    isWatchlist: true,
                    isScrollable: true,
                    height: 300,
                    movies: state.movies,
                    direction: Axis.horizontal,
                  ),
                ],
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
}
