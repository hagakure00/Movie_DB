import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviedb/Model/Movie.dart';
import 'package:moviedb/Utils/colors.dart';
import 'Movie_card.dart';


class MovieCategory extends StatelessWidget {
  const MovieCategory({Key? key, required this.label, required this.movieList, required this.imageHeight, required this.imageWidth, required this.callback}) : super(key: key);

  final String label;
  final List<Movie> movieList;
  final double imageHeight;
  final double imageWidth;
  final void Function()? callback;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(label, style: GoogleFonts.poppins(textStyle: const TextStyle(color: primary,fontSize: 18,letterSpacing: 1,decoration: TextDecoration.none))),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: imageHeight,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              final currentPosition = notification.metrics.pixels;
              final maxPosition = notification.metrics.maxScrollExtent;
              if(currentPosition >= maxPosition / 2){
                // chercher nouveau film
                callback!();
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
                        ? const Center(child: Text('erreur'))
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
