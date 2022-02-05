import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviedb/Model/Movie.dart';
import 'package:moviedb/Repository/DataRepository.dart';
import 'package:moviedb/Utils/colors.dart';
import 'package:moviedb/Widgets/Movie_search.dart';
import 'package:moviedb/Widgets/Serie/Serie_search.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);


  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final List<Movie> movieList = [];
  TextEditingController queryController = TextEditingController();
  bool isExecute = false;
  bool isClicked = false;


  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Scaffold(
      backgroundColor: body,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset("assets/images/logodb.png"),
        ),
        title: Text("Movie DB",
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: primary,
                    fontSize: 18,
                    height: 2,
                    letterSpacing: 1,
                    decoration: TextDecoration.none))),
        backgroundColor: background,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            buildTextField(context),
            buildButton(context),


            const SizedBox(height: 20),
            isExecute ? SizedBox(
             height: 300,
             width: MediaQuery.of(context).size.width -10,
             child: isClicked
               ? (dataProvider.searchMovie.isNotEmpty || dataProvider.searchMovie != null)
                 ? MovieSearch(
                 movieList: dataProvider.searchMovie,
                 imageHeight: 300,
                 imageWidth: 200
             ) : Center(child: Text('Pas de résultat disponible', style: GoogleFonts.poppins(textStyle: const TextStyle(color: primary,fontSize: 14,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))))

             : (dataProvider.searchSerie.isNotEmpty || dataProvider.searchSerie != null)
                ? SerieSearch(
                serieList: dataProvider.searchSerie,
                imageHeight: 300,
                imageWidth: 200)
                : Center(child: Text('Pas de résultat disponible', style: GoogleFonts.poppins(textStyle: const TextStyle(color: primary,fontSize: 14,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))))


              ) : const SizedBox()
          ],
        )
      ),
    );
  }

  Widget buildTextField(context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: background, width: 0.0)),
          fillColor: Colors.grey.withOpacity(0.3),
          filled: true,
          prefixIcon: const Icon(Icons.search, color: primary,size: 20),
          suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  queryController.clear();
                  isExecute = false;
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                });
              },
              child: (queryController.text.isNotEmpty) ? const Icon(Icons.close,color: grey,size: 18) : const SizedBox()
          ),
        ),
        style: GoogleFonts.poppins( textStyle: const TextStyle(color: white,fontSize: 13,decoration: TextDecoration.none)),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        cursorColor: primary,
        controller: queryController,
        onChanged: (value) {
          setState(() {
            (queryController.text.isNotEmpty) ? isExecute = true : isExecute = false;
            dataProvider.searchMovie.clear();
            dataProvider.searchSerie.clear();
          });
        },
      ),
    );
  }

  Widget buildButton(context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(onPressed: () {
          isClicked = true;
          setState(() {
            dataProvider.getSearchMovies(key: queryController.text);
            (queryController.text.isNotEmpty) ? isExecute = true : isExecute = false;
            dataProvider.searchMovie.clear();
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          });
        },
            child: Text('Rechercher un Film', style: GoogleFonts.poppins(textStyle: const TextStyle(color: white,fontSize: 14,height: 1.5,decoration: TextDecoration.none)))
        ),

        ElevatedButton(onPressed: () {
          isClicked = false;
          setState(() {
            dataProvider.getSearchSeries(key: queryController.text);
            (queryController.text.isNotEmpty) ? isExecute = true : isExecute = false;
            dataProvider.searchSerie.clear();
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          });
        },
            child: Text('Rechercher une Série', style: GoogleFonts.poppins(textStyle: const TextStyle(color: white,fontSize: 14,height: 1.5,decoration: TextDecoration.none)))
        ),
      ],);
  }

}
