import 'package:flutter/material.dart';
import 'package:the_movie_db/features/movie/presentation/screens/movies_screen.dart';


class AppRoutes {
  static final String initialRoute = RouterNames.movies;

  static Map<String, WidgetBuilder> routes = {
    RouterNames.movies: (_) => const MoviesScreen(),
  };

}

class RouterNames {
  static String movies = '/movies';

}
