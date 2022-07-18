import 'package:dicoding_tv_series/config/router/movie_route_name.dart';
import 'package:dicoding_tv_series/config/router/movie_router.dart';
import 'package:dicoding_tv_series/domain/entities/movie.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_popular_bloc/movie_popular_bloc_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_top_rated_bloc/movie_top_rated_bloc.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_watchlist_bloc/movie_wathclist_bloc.dart';
import 'package:dicoding_tv_series/presentation/widget/movie_card.dart';
import 'package:dicoding_tv_series/presentation/widget/title_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  var _searchMovie = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<MoviePopularBlocBloc>().add(LoadPopularMovie());
    context.read<MovieTopRatedBloc>().add(LoadMovieTopRated());
    context.read<MovieSearchBloc>().add(RemoveSearchMovieEvent());
    context.read<MovieWathclistBloc>().add(LoadMovieWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(29, 39, 39, 0),
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(29, 39, 39, 0),
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Search",
                        style: TextStyle(color: Colors.white70, fontSize: 30, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, movieTypeListPage, arguments: ListTypeMovieArgument("watchlist"));
                      },
                      icon: Icon(
                        Icons.movie_creation,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  controller: _searchMovie,
                  decoration: InputDecoration(
                    hintText: "Name of Movie , Actors",
                    hintStyle: TextStyle(
                      color: Colors.white54,
                      fontSize: 18,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70, width: 1, style: BorderStyle.solid),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.length > 1) {
                      context.read<MovieSearchBloc>().add(SearchMovieEvent(value));
                    } else {
                      context.read<MovieSearchBloc>().add(RemoveSearchMovieEvent());
                    }
                  },
                ),
                SizedBox(height: 20),
                BlocBuilder<MovieSearchBloc, MovieSearchBlocState>(builder: (context, state) {
                  if (state is MovieSearchBlocLoaded) {
                    return Container(
                      height: 500,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (state.movies.length),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          if (state.movies.length == 0) {
                            return Center(
                              child: Text('No Data', style: TextStyle(color: Colors.white, fontSize: 20)),
                            );
                          }
                          return ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, movieDetailPage, arguments: DetailMovieArgument(state.movies[index].movie()));
                            },
                            leading: Container(
                              child: Image(
                                image: NetworkImage("https://image.tmdb.org/t/p/w500/${state.movies[index].posterPath!}"),
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                            title: Text(
                              state.movies[index].title!,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is MovieSearchBlocError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else if (state is MovieSearchBlocLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieSearchBlocEmpty) {
                    return Column(
                      children: [
                        BlocConsumer<MovieWathclistBloc, MovieWathclistState>(
                          listener: (context, state) {},
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
                                          }),
                                      MovieListCard(
                                        length: 2,
                                        isWatchlist: true,
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
                        ),
                        TitleContent(
                            text: "Popular",
                            onPressed: () {
                              Navigator.pushNamed(context, movieTypeListPage, arguments: ListTypeMovieArgument("popular"));
                            }),
                        BlocBuilder<MoviePopularBlocBloc, MoviePopularBlocState>(builder: (context, state) {
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
                        }),
                        TitleContent(
                            text: "Top Movie",
                            onPressed: () {
                              Navigator.pushNamed(context, movieTypeListPage, arguments: ListTypeMovieArgument("topmovie"));
                            }),
                        BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(builder: (context, state) {
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
                        }),
                      ],
                    );
                  } else {
                    return Center(
                      child: Container(),
                    );
                  }
                }),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MovieListCard extends StatelessWidget {
  final int length;
  final List<Movie> movies;
  final Axis direction;
  final double height;
  final bool isWatchlist;
  const MovieListCard({
    Key? key,
    required this.length,
    required this.direction,
    required this.movies,
    required this.height,
    required this.isWatchlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: ListView.builder(
        scrollDirection: direction,
        itemCount: length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, movieDetailPage, arguments: DetailMovieArgument(movies[index].movie()));
            },
            child: MovieCard(
              title: movies[index].title,
              posterPath: movies[index].posterPath,
              date: movies[index].releaseDate,
              overview: movies[index].overview,
              isWatchlist: isWatchlist,
            ),
          );
        },
      ),
    );
  }
}

//               Navigator.pushNamed(context, movieDetailPage, arguments: DetailMovieArgument(state.movies[index].movie()));
