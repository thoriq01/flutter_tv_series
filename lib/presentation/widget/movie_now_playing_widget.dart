import 'package:dicoding_tv_series/presentation/bloc/movie_now_playing_bloc/movie_now_playing_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieNowPlayingWidget extends StatelessWidget {
  const MovieNowPlayingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
      builder: (context, state) {
        if (state is MovienowPlayingLoading) {
          return Container();
        } else if (state is MovieNowPlayingError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is MovieNowPlayingLoaded) {
          if (state.movies.length > 0) {
            return MovieListCard(
              length: 2,
              isWatchlist: false,
              height: 500,
              movies: state.movies,
              isScrollable: false,
              direction: Axis.vertical,
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
