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
      child: Stack(
        children: [
          const Center(child: CircularProgressIndicator()),
          if (imageUrl.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage("$baseUrl${Config.defaultImageSize}$imageUrl"),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}