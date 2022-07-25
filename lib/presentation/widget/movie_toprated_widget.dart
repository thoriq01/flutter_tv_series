import 'package:dicoding_tv_series/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieTopRatedWidget extends StatelessWidget {
  const MovieTopRatedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(builder: (context, state) {
      if (state is MovieTopRatedLoaded) {
        return MovieListCard(
          length: 2,
          height: 500,
          isWatchlist: false,
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
  }
}
