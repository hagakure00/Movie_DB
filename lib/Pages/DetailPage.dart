import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviedb/Model/Movie.dart';
import 'package:moviedb/Repository/DataRepository.dart';
import 'package:moviedb/Utils/colors.dart';
import 'package:moviedb/Widgets/Movie_Detail_gallery.dart';
import 'package:moviedb/Widgets/Movie_Detail_info.dart';
import 'package:moviedb/Widgets/Movie_Detail_video.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Movie? newMovie;

  @override
  void initState() {
    super.initState();
    getMovieData();
  }

  void getMovieData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    // recuperer les detail du film
    Movie _movie = await dataProvider.getMovieDetails(movie: widget.movie);
    setState(() {
      newMovie = _movie;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: newMovie == null
          ? const Center(child: SpinKitFadingCircle(color: primary, size: 40))
          : SizedBox(
            height: MediaQuery.of(context).size.height,
            child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight:350,
                pinned: false,
                floating: false,
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        child: SizedBox(
                          height: 500,
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                              imageUrl: newMovie!.posterUrl(),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                      child: Icon(Icons.error_outline,
                                          color: grey, size: 20)),
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const SpinKitFadingCircle(
                                      color: primary, size: 20)),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          child: Container(
                            height: 500,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.1, 0.7],
                              colors: [body.withOpacity(0), body],
                            )),
                          )),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  MovieInfo(movie: newMovie!),

                  // player video
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,bottom: 5),
                    child: Text('Bande Annonce :', style: GoogleFonts.poppins(textStyle: const TextStyle(color: primary,fontSize: 16,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                        height: 220,
                        width: MediaQuery.of(context).size.width,
                        child: newMovie!.videos!.isEmpty
                            ? Column( mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(child: Icon(Icons.error_outline,color: grey,size: 30)),
                            Text("Pas de vidéo disponible", style: GoogleFonts.poppins(textStyle: const TextStyle(color: grey,fontSize: 12,height: 4,letterSpacing: 1,decoration: TextDecoration.none))),
                          ],)
                            : MyVideoPlayer(movieId: newMovie!.videos!.first)
                    ),
                  ),

                // images
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10,bottom: 5),
                  child: Text('Images du film :', style: GoogleFonts.poppins(textStyle: const TextStyle(color: primary,fontSize: 16,height: 1.5,letterSpacing: 1,decoration: TextDecoration.none))),
                ),

                // gallery
                const SizedBox(height: 10),
                SizedBox(
                    height: 150,
                    width: MediaQuery.of(context).size.width - 10,
                    child: ListView.builder(
                        itemCount: newMovie!.images!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int index) {
                          return MovieGalleryImage(posterPath: newMovie!.images![index]);
                        }
                    ),
                ),
                  const SizedBox(height: 30),

                ]),
              )
            ],
              ),
          ),
    );
  }
}

