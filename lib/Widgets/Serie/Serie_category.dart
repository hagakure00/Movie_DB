import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviedb/Model/Serie.dart';
import 'package:moviedb/Utils/colors.dart';
import '../Movie_card.dart';
import 'Serie_card.dart';


class SerieCategory extends StatelessWidget {
  const SerieCategory({Key? key, required this.label, required this.serieList, required this.imageHeight, required this.imageWidth, required this.callback}) : super(key: key);

  final String label;
  final List<Serie> serieList;
  final double imageHeight;
  final double imageWidth;
  final Function callback;

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
                callback();
              } return true;
            } ,
            child: ListView.builder(
                itemCount: serieList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: imageWidth,
                    child: serieList.isEmpty
                        ? Center(child: Text((index.toString())))
                        : SerieCard(
                        serie: serieList[index],
                        name: serieList[index].name,
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
