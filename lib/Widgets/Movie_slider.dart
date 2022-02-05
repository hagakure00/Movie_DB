import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviedb/Model/Movie.dart';
import 'package:moviedb/Repository/DataRepository.dart';
import 'package:moviedb/Utils/colors.dart';
import 'package:provider/provider.dart';
import 'Movie_card.dart';


class MovieSlider extends StatelessWidget {
  const MovieSlider({Key? key, required this.movieList, required this.imageHeight, required this.imageWidth, required this.callback}) : super(key: key);

  final List<Movie> movieList;
  final double imageHeight;
  final double imageWidth;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: imageHeight,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              final currentPosition = notification.metrics.pixels;
              final maxPosition = notification.metrics.maxScrollExtent;
              if(currentPosition >= maxPosition / 2){
                // chercher nouveau film
                callback();
              } return true;
            } ,
            child: ListView.builder(
                itemCount: movieList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: imageWidth,
                    child: movieList.isEmpty
                        ? Center(child: Text((index.toString())))
                        : MovieCard(
                        movie: movieList[index],
                        name: movieList[index].name,
                    ),
                  );
                }
            ),
          ),
        ),


      ],
    );
  }
}
