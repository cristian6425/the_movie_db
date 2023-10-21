import 'package:flutter/material.dart';
import 'package:the_movie_db/core/utils/extensions.dart';
import 'package:the_movie_db/features/movie/data/models/movie_model.dart';
import 'package:the_movie_db/features/movie/presentation/widgets/movie_image.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:
                      MovieImage(imageUrl: movie.posterPath)),
                  Text(movie.title,style: Theme.of(context).textTheme.titleLarge,textAlign: TextAlign.center,),
                  Padding(
                    padding: const EdgeInsets.only( top: 16.0),
                    child:  SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("- Gender: ${movie.genres}"),
                          Text("- Release date: ${movie.releaseDate.formatDate()}"),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(movie.overview),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}