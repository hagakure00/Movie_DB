import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviedb/Model/Movie.dart';
import 'package:moviedb/Utils/colors.dart';

import 'Casting_card.dart';



class MovieInfo extends StatelessWidget {
  const MovieInfo({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movie.name, style: GoogleFonts.poppins(textStyle: const TextStyle(color: primary,fontSize: 20,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))),
              const SizedBox(height: 15),
              Text(movie.reformatGenres(), style: GoogleFonts.poppins(textStyle: const TextStyle(color: white,fontSize: 14,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))),
              const SizedBox(height: 10),
              Row(children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // choisir l'année de la date uniquement avec substring
                  child: Text(movie.releaseDate!.substring(0, 4), style: GoogleFonts.poppins(textStyle: const TextStyle(color: white,fontSize: 14,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))),
                ),
                const SizedBox(width: 20),
                Text('Recommandé a ${(movie.vote! * 10).toInt()}%', style: GoogleFonts.poppins(textStyle: const TextStyle(color: primary,fontSize: 14,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))),
              ],),
              const SizedBox(height: 20),
              Text(movie.description, style: GoogleFonts.poppins(textStyle: const TextStyle(color: white,fontSize: 13,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))),

              const SizedBox(height: 20),
              Text('Casting :', style: GoogleFonts.poppins(textStyle: const TextStyle(color: primary,fontSize: 16,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))),
              const SizedBox(height: 10),
              SizedBox(
                height: 350,
                child: ListView.builder(
                    itemCount: movie.casting!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, int index) {
                      return movie.casting![index].imageUrl == null
                          ? const Center (child: Icon(Icons.error_outline,color: grey,size: 20))
                          : CastingCard(person: movie.casting![index]);
                    }
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
