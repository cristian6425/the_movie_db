import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_db/features/movie/presentation/blocs/movie_bloc.dart';
import 'package:the_movie_db/features/movie/presentation/widgets/list_movies.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<MovieBloc, MovieState>(
      listener: (context, state) {
        if (state.status == Status.failure && state.errorMessage!="") {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Movies'),
        ),
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            return Stack(
              children: [
                if (state.movies.isNotEmpty)
                  const ListMovies(),
                if (state.movies.isEmpty &&
                    state.status != Status.initial)
                  const Center(child: Text('no movies')),
                if (state.loading)
                  const Center(child: CircularProgressIndicator()),
              ],
            );
          },
        ),
      ),
    );
  }
}