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
    on<MovieInitialStateEvent>(_onInitialState);
    on<MovieEvent>(_onRefreshListMovies);
    on<ShowErrorMessageEvent>(_onShowError);
    on<SearchMovieEvent>(_onSearchMovie);
  }

  final MovieUseCase _movieUseCase;

  Future<void> _onInitialState(MovieEvent event, Emitter<MovieState> emit) async {
    emit(state.copyWith(loading: true));
    final (genres, baseUrl) = await _movieUseCase.getInitConfig();
    final (movieResponse,isCache) = await _movieUseCase.getMovies(genres);
    emit(state.copyWith(
        status: Status.success,
        loading: false,
        movies: movieResponse.results as List<MovieModel>,
        genres: genres,
        baseUrl: baseUrl,
      page: movieResponse.page,
      totalPages: movieResponse.totalPages
    ));
    if (movieResponse.results.isNotEmpty && !isCache){
      await _movieUseCase.saveMovies(movieResponse);
    }

  }

  Future<void> _onRefreshListMovies(MovieEvent event, Emitter<MovieState> emit) async {
    if (state.hasReachedMax) return;
    if (state.loading) return;
    if (state.page < state.totalPages) {
      emit(state.copyWith(loading: true));
      final (response,isCache) = await _movieUseCase.getMovies(state.genres,page: state.page + 1);
      if (response.results.isNotEmpty && !isCache){
        List<MovieModel> newMovieList = List.of(state.movies)..addAll(response.results as List<MovieModel>);
        emit(state.copyWith(
            movies: newMovieList,
            page: response.page,
            totalPages: response.totalPages,));
        await _movieUseCase.saveMovies(response.copyWith(page: state.page, movies: newMovieList));
      }
      emit(state.copyWith(
          status: Status.success,
          hasReachedMax: false,
          loading: false));
    }
  }

  Future<void> _onShowError(ShowErrorMessageEvent event, Emitter<MovieState> emit) async {
    emit(state.copyWith(status: Status.failure, loading: false, errorMessage: event.errorMessage));
  }


  Future<void> _onSearchMovie(SearchMovieEvent event, Emitter<MovieState> emit) async {
    if (state.loading) return;
      emit(state.copyWith(loading: true));
      final (response,isCache) = await _movieUseCase.getMovies(state.genres,page: state.page + 1);
      if (response.results.isNotEmpty && !isCache){
        List<MovieModel> newMovieList = List.of(state.movies)..addAll(response.results as List<MovieModel>);
        emit(state.copyWith(
          movies: newMovieList,
          page: response.page,
          totalPages: response.totalPages,));
        await _movieUseCase.saveMovies(response.copyWith(page: state.page, movies: newMovieList));
      }
      emit(state.copyWith(
          status: Status.success,
          hasReachedMax: false,
          loading: false));

  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    add(ShowErrorMessageEvent(error.toString()));
    super.onError(error, stackTrace);
  }
}
