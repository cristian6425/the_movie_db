part of 'movie_bloc.dart';

enum Status { initial, success, failure }

class MovieState extends Equatable {
  final Status status;

  final List<MovieModel> movies;
  final bool hasReachedMax;
  final bool loading;
  final String errorMessage;
  final String baseUrl;
  final List<GenreModel> genres;
  final int page;
  final int totalPages;

  const MovieState({
    this.status = Status.initial,
    this.movies = const <MovieModel>[],
    this.hasReachedMax = false,
    this.loading = true,
    this.errorMessage = "",
    this.baseUrl = "",
    this.genres = const [],
    this.page = 1,
    this.totalPages = 0,
  });

  MovieState copyWith({
    Status? status,
    List<MovieModel>? movies,
    bool? hasReachedMax,
    bool? loading,
    bool? failure,
    String? errorMessage,
    String? baseUrl,
    List<GenreModel>? genres,
    int? page,
    int? totalPages,
  }) {
    return MovieState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? "",
      baseUrl: baseUrl ?? this.baseUrl,
      genres: genres ?? this.genres,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object> get props => [status, movies, hasReachedMax, loading, errorMessage, baseUrl, genres, page, totalPages];
}
