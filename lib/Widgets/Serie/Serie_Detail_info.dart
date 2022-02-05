import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:moviedb/Model/Serie.dart';
import 'package:moviedb/Utils/colors.dart';

import '../Casting_card.dart';



class SerieInfo extends StatelessWidget {
  const SerieInfo({Key? key, required this.serie}) : super(key: key);

  final Serie serie;

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
              Text(serie.name, style: GoogleFonts.poppins(textStyle: const TextStyle(color: primary,fontSize: 20,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))),
              const SizedBox(height: 15),
              Text(serie.reformatGenres(), style: GoogleFonts.poppins(textStyle: const TextStyle(color: white,fontSize: 14,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))),
              const SizedBox(height: 20),
              Row(children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  // choisir l'année de la date uniquement avec substring
                  child: Text("${serie.firstTime!.substring(0, 4)} - ${serie.lastTime!.substring(0, 4)}", style: GoogleFonts.poppins(textStyle: const TextStyle(color: white,fontSize: 14,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))),
                ),
                const SizedBox(width: 20),
                // langue
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(serie.langue.toString(), style: GoogleFonts.poppins(textStyle: const TextStyle(color: white,fontSize: 14,letterSpacing: 1,decoration: TextDecoration.none)))),
                const SizedBox(width: 20),
                Text('Recommandé a ${(serie.vote! * 10).toInt()}%', style: GoogleFonts.poppins(textStyle: const TextStyle(color: primary,fontSize: 14,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))),

              ],),


              const SizedBox(height: 20),
              Row(children: [
                // time
                Row(
                  children: [
                    const Icon(Ionicons.timer_outline,color: primary,size: 20),
                    const SizedBox(width: 10),
                    Text("${serie.seasons.toString()} Saisons", style: GoogleFonts.poppins(textStyle: const TextStyle(color: white,fontSize: 13,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))),
                  ],
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    const Icon(Ionicons.play_circle_outline,color: primary,size: 20),
                    const SizedBox(width: 10),
                    (serie.isProduct == true)
                        ? Text('En Cours', style: GoogleFonts.poppins(textStyle: const TextStyle(color: white,fontSize: 13,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none)))
                        : Text('Terminé', style: GoogleFonts.poppins(textStyle: const TextStyle(color: white,fontSize: 13,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))),

                  ],
                ),

              ],),


              const SizedBox(height: 20),
              Text(serie.description, style: GoogleFonts.poppins(textStyle: const TextStyle(color: white,fontSize: 13,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))),



              const SizedBox(height: 20),
              Text('Casting :', style: GoogleFonts.poppins(textStyle: const TextStyle(color: primary,fontSize: 16,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))),
              const SizedBox(height: 10),
              SizedBox(
                height: 350,
                child: ListView.builder(
                    itemCount: serie.casting!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, int index) {
                      return serie.casting![index].imageUrl == null
                          ? const Center (child: Icon(Icons.error_outline,color: grey,size: 20))
                          : CastingCard(person: serie.casting![index]);
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
