import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviedb/Model/Movie.dart';
import 'package:moviedb/Model/Person.dart';
import 'package:moviedb/Utils/colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';



class NoteCard extends StatelessWidget {
  const NoteCard({Key? key, required this.person}) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {

    double value = person.popularity! /100;

    return SizedBox(
      width: (MediaQuery.of(context).size.width - 40) * 0.4,
      child: Stack(
        children: [
          RotatedBox(
            quarterTurns: -2,
            child: CircularPercentIndicator(
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: grey.withOpacity(0.3),
                radius: 20.0,
                lineWidth: 6.0,
                percent: (value.isNaN) ? 0.0 : value,
                progressColor: primary),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: SizedBox(
              width: 20,
              height: 18,
              child: Text(person.popularity!.toString(),
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: primary,
                          fontSize: 15,
                          decoration: TextDecoration.none))),
            ),
          )
        ],)
      );

  }
}

