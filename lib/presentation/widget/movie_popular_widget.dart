import 'package:dicoding_tv_series/presentation/bloc/movie_popular_bloc/movie_popular_bloc_bloc.dart';
import 'package:dicoding_tv_series/presentation/pages/movie_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviePopularBlocWidget extends StatelessWidget {
  const MoviePopularBlocWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviePopularBlocBloc, MoviePopularBlocState>(builder: (context, state) {
      if (state is MoviePopularLoaded) {
        return MovieListCard(
          length: 2,
          height: 500,
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
  }
}
