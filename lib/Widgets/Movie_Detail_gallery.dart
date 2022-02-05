import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moviedb/Services/Api.dart';
import 'package:moviedb/Utils/colors.dart';


class MovieGalleryImage extends StatelessWidget {
  const MovieGalleryImage({Key? key, required this.posterPath}) : super(key: key);

  final String posterPath;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 150,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: CachedNetworkImage(
            width: 300,
            imageUrl: Api().baseImageUrl + posterPath,
            errorWidget: (context, url, error) => const Center(child: Icon(Icons.error_outline,color: grey,size: 20)),
            fit: BoxFit.cover,
            placeholder: (context, url) => const SpinKitFadingCircle(color: primary,size: 20)
        ),
      ),);
  }
}
