import 'package:the_movie_db/core/data/models/genre_model.dart';
import 'package:the_movie_db/features/movie/data/models/movie_response_model.dart';

abstract class IMovieRepository {

  Future <(MovieResponseModel,bool)>getMovies(int page);

  Future <List<GenreModel>>getGenres();

  Future <String> getBaseUrl();

  Future <void> saveMovies(MovieResponseModel moviesResponse);
}