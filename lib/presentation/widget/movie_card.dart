import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? date;
  final bool? isWatchlist;
  const MovieCard({
    Key? key,
    this.title,
    this.posterPath,
    this.overview,
    this.date,
    this.isWatchlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 10),
      // ignore: unrelated_type_equality_checks
      child: isWatchlist == true ? _vertical() : _horizontal(),
    );
  }

  Row _horizontal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${this.posterPath}',
              width: 160,
            ),
          ),
        ),
        SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200,
              child: Text(
                this.title!,
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 15),
            Container(
                width: 200,
                child: Text(this.overview.toString(), maxLines: 3, softWrap: true, style: TextStyle(color: Colors.white70, fontSize: 16))),
            SizedBox(height: 15),
            Text(
              "release date",
              style: TextStyle(color: Colors.white),
            ),
            Text(this.date ?? "", style: TextStyle(color: Colors.white70, fontSize: 16)),
            SizedBox(height: 5),
          ],
        )
      ],
    );
  }

  Column _vertical() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${this.posterPath}',
              width: 160,
            ),
          ),
        ),
        SizedBox(width: 15),
        Container(
          width: 200,
          child: Text(
            this.title!,
            style: TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
