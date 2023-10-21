import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:the_movie_db/core/data/models/genre_model.dart';
import 'package:the_movie_db/features/movie/data/models/movie_model.dart';
import 'package:the_movie_db/features/movie/domain/use_cases/movie_use_case.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc({required MovieUseCase movieUseCase})
      : _movieUseCase = movieUseCase,
        super(const MovieState()) {
    on<MovieInitialState>(_initialState);
    on<MovieEvent>(_refreshListMovies);
  }

  final MovieUseCase _movieUseCase;

  Future<void> _initialState(MovieEvent event, Emitter<MovieState> emit) async {
    try {
      final (genres, baseUrl) = await _movieUseCase.getInitConfig();
      final movies = await _movieUseCase.getMovies(genres);
      emit(state.copyWith(
          status: Status.success,
          loading: false,
          movies: movies.results as List<MovieModel>,
          genres: genres,
          baseUrl: baseUrl,
        page: movies.page,
        totalPages: movies.totalPages
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, loading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _refreshListMovies(MovieEvent event, Emitter<MovieState> emit) async {
    if (state.hasReachedMax) return;
    if (state.loading) return;
    try {
      if (state.page < state.totalPages) {
        emit(state.copyWith(loading: true));
        final response = await _movieUseCase.getMovies(state.genres,page: state.page + 1);
        List<MovieModel> newList = List.of(state.movies)..addAll(response.results as List<MovieModel>);
        emit(state.copyWith(
            status: Status.success,
            movies: newList,
            hasReachedMax: false,
            page: response.page,
            totalPages: response.totalPages,
            loading: false));
      }
    } catch (e) {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: Status.failure, loading: false, errorMessage: e.toString()));
    }
  }
}
