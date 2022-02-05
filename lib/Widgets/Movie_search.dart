import 'package:flutter/material.dart';
import 'package:moviedb/Model/Movie.dart';
import 'Movie_card.dart';

class MovieSearch extends StatelessWidget {
  const MovieSearch({Key? key, required this.movieList, required this.imageHeight, required this.imageWidth,}) : super(key: key);

  final List<Movie> movieList;
  final double imageHeight;
  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imageHeight,
      child: ListView.builder(
          itemCount: movieList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: imageWidth,
                    child: movieList.isEmpty
                        ? const Center(child: Text('erreur'))
                        : MovieCard(
                        movie: movieList[index],
                        name: movieList[index].name)
                )
              ],
            );
          }
      ),
    );
  }
}
