import 'package:flutter/material.dart';
import 'package:moviedb/Pages/SearchPage.dart';
import 'package:moviedb/Repository/DataRepository.dart';
import 'package:moviedb/Utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviedb/Widgets/Movie_category.dart';
import 'package:moviedb/Widgets/Movie_slider.dart';
import 'package:moviedb/Widgets/Serie/Serie_category.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);

    final tabSelect = <Widget>[
      const Tab(text: 'Animation'),
      const Tab(text: 'Aventure'),
      const Tab(text: 'Comedie'),
      const Tab(text: 'Thriller'),
      const Tab(text: 'Fiction'),];

    final tabView = [
      MovieSlider(
          movieList: dataProvider.animationMovies,
          imageHeight: 300,
          imageWidth: 200,
          callback: dataProvider.getAnimationMovies
      ),
      MovieSlider(
          movieList: dataProvider.aventureMovies,
          imageHeight: 300,
          imageWidth: 200,
          callback: dataProvider.getAventureMovies
      ),
      MovieSlider(
          movieList: dataProvider.comedieMovies,
          imageHeight: 300,
          imageWidth: 200,
          callback: dataProvider.getComedieMovies
      ),
      MovieSlider(
          movieList: dataProvider.thrillerMovies,
          imageHeight: 300,
          imageWidth: 200,
          callback: dataProvider.getThrillerMovies
      ),
      MovieSlider(
          movieList: dataProvider.fictionMovies,
          imageHeight: 300,
          imageWidth: 200,
          callback: dataProvider.getFictionMovies
      ),
    ];

    return Scaffold(
      backgroundColor: background.withOpacity(0.5),
      appBar: AppBar(
        leading: Padding(padding: const EdgeInsets.only(left: 10),child: Image.asset("assets/images/logodb.png"),),
        title: Text("Movie DB", style: GoogleFonts.poppins(textStyle: const TextStyle(color: primary,fontSize: 18,height: 2,letterSpacing: 1,decoration: TextDecoration.none))),
      backgroundColor: background,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  const SearchPage()));
              },
              icon: const Icon(Icons.search,color: primary, size: 20))
        ],
      ),
      body: DefaultTabController(
        length: tabSelect.length,
        child: ListView(
          children: [

          Container(
            color: background,
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: TabBar(indicatorColor: primary, tabs: tabSelect,labelColor: primary),
          ),
          SizedBox(
            height: 300,
            child: TabBarView(children: tabView,)
          ),


            MovieCategory(
                label: "Actuellement au cinéma",
                movieList: dataProvider.nowPlaying,
                imageHeight: 300,
                imageWidth: 200,
                callback: dataProvider.getNowPlaying,
            ),

            MovieCategory(
                label: "Bientot en salle",
                movieList: dataProvider.comingMovie,
                imageHeight: 300,
                imageWidth: 200,
                callback: dataProvider.getComingMovies,
            ),

            ////////
            // SERIE
            /////////

            SerieCategory(
                label: "Serie populaires",
                serieList: dataProvider.popularSerieList,
                imageHeight: 300,
                imageWidth: 200,
                callback: dataProvider.getPopularSeries
            ),

            SerieCategory(
                label: "Serie les mieux noté",
                serieList: dataProvider.topSerieList,
                imageHeight: 300,
                imageWidth: 200,
                callback: dataProvider.getPopularSeries
            ),

            const SizedBox(height:20),


          ],
        ),
      ),
    );
  }
}
