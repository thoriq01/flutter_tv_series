import 'package:dicoding_tv_series/domain/entities/movie_detail.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_cast_bloc/movie_cast_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                          height: 400,
                          width: double.infinity,
                          child: Image(
                              fit: BoxFit.fitWidth,
                              width: 500,
                              image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${state.movieDetail.posterPath}',
                              )),
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
                            Text(
                              state.movieDetail.releaseDate,
                              style: TextStyle(fontSize: 12, color: Colors.white),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Overview",
                              style: TextStyle(fontSize: 18, color: Colors.white70),
                            ),
                            BlocConsumer<MovieWathclistBloc, MovieWathclistState>(
                              buildWhen: (previous, current) {
                                if (current is MovieWatchlistIsAdded) {
                                  return current is MovieWatchlistIsAdded;
                                } else {
                                  return current is MovieWatchlistSuccessRemoved;
                                }
                              },
                              listener: (context, state) {
                                if (state is MovieWatchlistSuccessAdd) {
                                  _showNotification(context, "Added to watchlist");
                                } else if (state is MovieWatchlistSuccessRemoved) {
                                  _showNotification(context, "Removed from watchlist");
                                }
                              },
                              builder: (context, state) {
                                if (state is MovieWatchlistIsAdded) {
                                  return IconButton(
                                    icon: Icon(
                                      Icons.add_alert_rounded,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      context.read<MovieWathclistBloc>().add(RemoveMovieWatchlist(this.widget.movie!));
                                    },
                                  );
                                } else {
                                  return IconButton(
                                    icon: Icon(
                                      Icons.add_alert_outlined,
                                      color: Colors.white,
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
                          height: 200,
                          child: ListView.builder(
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
                              }),
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
