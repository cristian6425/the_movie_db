
import 'package:the_movie_db/core/data/models/genre_model.dart';
import 'package:the_movie_db/features/movie/data/models/movie_model.dart';
import 'package:the_movie_db/features/movie/data/models/movie_response_model.dart';
import 'package:the_movie_db/features/movie/domain/repositories/i_movie_repository.dart';

class MovieUseCase {
  final IMovieRepository _movieRepository;

  MovieUseCase(this._movieRepository);

  Future<(MovieResponseModel,bool)> getMovies(List<GenreModel> genres,{int page = 1}) async {
    final (movies,isCache) = await _movieRepository.getMovies(page);
    List<MovieModel> moviesWithGenres = [];
    for (var element in (movies.results as List<MovieModel>)) {
      moviesWithGenres.add(element.copyWith(
      genres: element.genreIds.map((e) => genres.firstWhere((element) => element.id == e).name).toList().toString().replaceAll("[", "").replaceAll("]", "")
    ));
    }

    return (movies.copyWith(movies: moviesWithGenres),isCache);
  }

  Future<(List<GenreModel>,String)> getInitConfig() async {
    final genres = await _movieRepository.getGenres();
    final String baseUrl = await _movieRepository.getBaseUrl();
    return (genres,baseUrl);
  }

  Future<void> saveMovies (MovieResponseModel movieResponse) => _movieRepository.saveMovies(movieResponse);


}