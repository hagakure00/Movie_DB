import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviedb/Model/Movie.dart';
import 'package:moviedb/Pages/DetailPage.dart';
import 'package:moviedb/Utils/colors.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.movie, required this.name,})
      : super(key: key);

  final Movie movie;
  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(movie: movie)));
        },
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: SizedBox(
                height: 300,
                width: 200,
                child: CachedNetworkImage(
                    imageUrl: movie.posterUrl(),
                    errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error_outline, color: grey, size: 20)),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                        child: SpinKitFadingCircle(color: primary, size: 20))),
              ),
            ),
            Positioned(
                top: 0,
                child: Container(
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.4, 0.8],
                    colors: [Colors.black.withOpacity(0), Colors.black.withOpacity(0.8)],
                  )),
                )),
            Positioned(
              bottom: 10,
              left: 10,
              child: SizedBox(
                  width: 200 - 20,
                  child: Text(name,
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: white,
                              fontSize: 14,
                              height: 1,
                              letterSpacing: 1,
                              decoration: TextDecoration.none)))),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: SizedBox(
                width: 200 - 20,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      // choisir l'année de la date uniquement avec substring
                      child: Text(movie.releaseDate.substring(0, 4),
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: white,
                                  fontSize: 14,
                                  height: 1.5,
                                  letterSpacing: 1,
                                  decoration: TextDecoration.none))),
                    ),
                    const SizedBox(width: 10),
                    // langue
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(movie.langue,
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: white,
                                    fontSize: 14,
                                    letterSpacing: 1,
                                    decoration: TextDecoration.none)))),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
