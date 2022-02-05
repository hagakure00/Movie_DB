import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviedb/Model/Person.dart';
import 'package:moviedb/Services/Api.dart';
import 'package:moviedb/Utils/colors.dart';
import 'package:moviedb/Widgets/Note_card.dart';


class CastingCard extends StatelessWidget {
  const CastingCard({Key? key, required this.person}) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: background,
        elevation: 2,
        child: Column(
          children: [
            ClipRRect(
              borderRadius:  BorderRadius.circular(5),
              child: SizedBox(
                width: 160,
                height: 220,
                child: Stack(children: [
                  Positioned(
                    top: 0,
                    child: CachedNetworkImage(
                      width: 160,
                      imageUrl: Api().baseImageUrl + person.imageUrl!,
                      errorWidget: (context, url, error) => const Center(child: Icon(Icons.error_outline,color: grey,size: 20)),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: SpinKitFadingCircle(color: primary,size: 20))
                  ),),
                  Positioned(
                    bottom: 10,
                    left: 110,
                    child: NoteCard(person: person))
                ],),
              )

            ),
            Padding(padding: const EdgeInsets.only(top: 10,left: 10),
              child: SizedBox(
                width: 150,
                child: Text(person.name, style: GoogleFonts.poppins(textStyle: const TextStyle(color: primary,fontSize: 15,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))),
              ),
            ),
            Padding(padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 150,
                child: Text(person.characterName, style: GoogleFonts.poppins(textStyle: const TextStyle(color: white,fontSize: 13,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
