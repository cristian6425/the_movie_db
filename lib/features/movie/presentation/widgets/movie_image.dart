import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_db/config/config.dart';
import 'package:the_movie_db/features/movie/presentation/blocs/movie_bloc.dart';

class MovieImage extends StatelessWidget {
  final String imageUrl;

  const MovieImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width > 300.0) {
      width = 300.0;
    }
    final baseUrl = context.read<MovieBloc>().state.baseUrl;
    return  SizedBox(
      width: width / 3,
      height: width / 1.5,
      child: CachedNetworkImage(imageUrl: "$baseUrl${Config.defaultImageSize}$imageUrl",
        placeholder: (context, url) => Container(
            margin: const EdgeInsets.only(top:70,bottom: 70,left: 35,right: 35),
            child: const CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.broken_image),
      ),
    );
  }
}