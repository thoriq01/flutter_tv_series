import 'package:dicoding_tv_series/config/router/movie_route_name.dart';
import 'package:dicoding_tv_series/config/router/movie_router.dart';
import 'package:dicoding_tv_series/domain/entities/movie_detail.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_cast_bloc/movie_cast_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_recomendation_bloc/movie_recomendation_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  final MovieDetail? movie;
  const MovieDetailPage({Key? key, this.movie}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailBloc>().add(LoadMovieDetail(this.widget.movie!.id));
    context.read<MovieCastBloc>().add(LoadMovieCast(this.widget.movie!.id));
    context.read<MovieWathclistBloc>().add(CheckIsAddedMovieWatchlist(this.widget.movie!.id));
    context.read<MovieRecomendationBloc>().add(LoadMovieRecomendation(this.widget.movie!.id));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              clipBehavior: Clip.hardEdge,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  BlocBuilder<MovieDetailBloc, MovieDetailState>(
                    builder: (context, state) {
                      if (state is MovieDetailLoading) {
                        return MovieLoadingData();
                      } else if (state is MovieDetailLoaded) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              height: 500,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${state.movieDetail.posterPath}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, movieListPage);
                                },
                                icon: Center(
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200,
                                  child: Text(
                                    state.movieDetail.title,
                                    style: TextStyle(fontSize: 18, color: Colors.white),
                                  ),
                                ),
                                SizedBox(width: 30),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.date_range_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    Text(
                                      state.movieDetail.releaseDate,
                                      style: TextStyle(fontSize: 14, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            Row(
                              children: [
                                ...state.movieDetail.genres.map((e) {
                                  return Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
                                      margin: EdgeInsets.symmetric(horizontal: 5),
                                      child: Text(
                                        e.name,
                                        style: TextStyle(fontSize: 14, color: Colors.white70),
                                      ));
                                })
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.star, color: Colors.orangeAccent, size: 20),
                                Text(
                                  (state.movieDetail.voteAverage).toString(),
                                  style: TextStyle(fontSize: 14, color: Colors.white70),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Overview",
                                  style: TextStyle(fontSize: 18, color: Colors.white70),
                                ),
                                BlocConsumer<MovieWathclistBloc, MovieWathclistState>(
                                  listener: (context, state) {
                                    if (state is MovieWatchlistSuccessAdd) {
                                      _showNotification(context, "Added to watchlist");
                                    } else if (state is MovieWatchlistSuccessRemoved) {
                                      _showNotification(context, "Removed from watchlist");
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is MovieWatchlistIsAdded) {
                                      return OutlinedButton(
                                        style: OutlinedButton.styleFrom(primary: Colors.red, elevation: 1, backgroundColor: Colors.white12),
                                        child: Text("Remove Watchlist"),
                                        onPressed: () {
                                          context.read<MovieWathclistBloc>().add(RemoveMovieWatchlist(this.widget.movie!));
                                        },
                                      );
                                    } else {
                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(primary: Colors.white),
                                        child: Text(
                                          "Add To Watchlist",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onPressed: () {
                                          context.read<MovieWathclistBloc>().add(AddMovieWatchlist(this.widget.movie!));
                                        },
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              state.movieDetail.overview,
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            // Text(state.movieDetail)
                          ],
                        );
                      } else {
                        return Center(
                          child: Text(""),
                        );
                      }
                    },
                  ),
                  BlocBuilder<MovieCastBloc, MovieCastState>(
                    builder: (context, state) {
                      if (state is MovieDetailLoading) {
                        return Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      } else if (state is MovieCastLoaded) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            Text(
                              "The Actor",
                              style: TextStyle(fontSize: 18, color: Colors.white70),
                            ),
                            SizedBox(height: 15),
                            Container(
                              height: 170,
                              child: _listActor(state),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: Text(""),
                        );
                      }
                    },
                  ),
                  BlocBuilder<MovieRecomendationBloc, MovieRecomendationState>(
                    builder: (context, state) {
                      if (state is MovieRecomendationLoading) {
                        return MovieLoadingData();
                      } else if (state is MovieRecomendationLoaded) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recomendation",
                              style: TextStyle(fontSize: 18, color: Colors.white70),
                            ),
                            SizedBox(height: 15),
                            Container(
                              height: 200,
                              child: _listRecomendation(state),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: Text(""),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ListView _listRecomendation(MovieRecomendationLoaded state) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: state.movies.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, movieDetailPage, arguments: DetailMovieArgument(state.movies[index].movie())),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${state.movies[index].posterPath}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 100,
                child: Text(
                  state.movies[index].title!,
                  style: TextStyle(fontSize: 15, color: Colors.white70),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ListView _listActor(MovieCastLoaded state) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: state.movieCast.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${state.movieCast[index].profilePath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 100,
              child: Text(
                state.movieCast[index].originalName,
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
            ),
          ],
        );
      },
    );
  }

  _showNotification(BuildContext context, String text) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 100,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: Center(
          child: Text(text, style: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}

class MovieLoadingData extends StatelessWidget {
  const MovieLoadingData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: Colors.white),
    );
  }
}
