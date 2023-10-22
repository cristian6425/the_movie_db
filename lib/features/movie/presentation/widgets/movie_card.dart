import 'package:flutter/material.dart';
import 'package:the_movie_db/core/utils/extensions.dart';
import 'package:the_movie_db/features/movie/data/models/movie_model.dart';
import 'package:the_movie_db/features/movie/presentation/screens/movie_details_screen.dart';
import 'package:the_movie_db/features/movie/presentation/widgets/movie_image.dart';


class MovieCard extends StatefulWidget {
  final MovieModel movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: detailOnClink,
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MovieImage(
              imageUrl: widget.movie.posterPath,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(widget.movie.title,style: Theme.of(context).textTheme.titleLarge, maxLines: 3, overflow: TextOverflow.ellipsis,),
                      Text("Genres: ${widget.movie.genres}",style: Theme.of(context).textTheme.titleMedium, maxLines: 2, overflow: TextOverflow.ellipsis,),
                      Text("Release date: ${widget.movie.releaseDate.formatDate()}",style: Theme.of(context).textTheme.bodySmall,maxLines: 4, overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void detailOnClink(){
    {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetailsScreen(
            movie: widget.movie,
          ),
        ),
      );
    }
  }
}