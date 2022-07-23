import 'package:dicoding_tv_series/domain/entities/movie_detail.dart';
import 'package:dicoding_tv_series/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailPages extends StatefulWidget {
  final MovieDetail? id;
  const MovieDetailPages({Key? key, this.id}) : super(key: key);

  @override
  State<MovieDetailPages> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPages> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailBloc>().add(LoadMovieDetail(this.widget.id!.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100,
        child: BlocConsumer<MovieDetailBloc, MovieDetailState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return MovieLoadingData();
            } else if (state is MovieDetailLoaded) {
              return Container(height: 200, child: Column());
            } else {
              return Text("Loading");
            }
          },
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
