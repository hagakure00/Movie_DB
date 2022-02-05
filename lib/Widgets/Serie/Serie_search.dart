import 'package:flutter/material.dart';
import 'package:moviedb/Model/Serie.dart';
import 'package:moviedb/Widgets/Serie/Serie_card.dart';
import '../Movie_card.dart';


class SerieSearch extends StatelessWidget {
  const SerieSearch({Key? key, required this.serieList, required this.imageHeight, required this.imageWidth,}) : super(key: key);

  final List<Serie> serieList;
  final double imageHeight;
  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imageHeight,
      child: ListView.builder(
          itemCount: serieList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: imageWidth,
                  child: serieList.isEmpty
                      ? const Center(child: Text('erreur'))
                      : SerieCard(
                      serie: serieList[index],
                      name: serieList[index].name)
                )
              ],
            );
          }
      ),
    );
  }
}
