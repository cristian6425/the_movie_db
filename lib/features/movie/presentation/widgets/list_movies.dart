import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_db/features/movie/presentation/blocs/movie_bloc.dart';
import 'package:the_movie_db/features/movie/presentation/widgets/movie_card.dart';

class ListMovies extends StatefulWidget {
  const ListMovies({Key? key}) : super(key: key);

  @override
  State<ListMovies> createState() => _ListMoviesState();
}

class _ListMoviesState extends State<ListMovies> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }
  void _onScroll() {
    if (_isBottom) context.read<MovieBloc>().add(GetMovies());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    int crossAxisCount = (mediaQuery.size.width / 450).round();

    return BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          return GridView.builder(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                childAspectRatio: 16 / 7,
              ),
              itemCount: state.movies.length,
              itemBuilder: (BuildContext context, index) {
                return MovieCard(movie: state.movies[index]);
              });
        });
  }
}