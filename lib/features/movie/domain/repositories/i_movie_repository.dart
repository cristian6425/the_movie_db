
import 'package:the_movie_db/core/data/models/genre_model.dart';
import 'package:the_movie_db/features/movie/data/models/movie_response_model.dart';

abstract class IMovieRepository {

  Future <MovieResponseModel>getMovies(int page);

  Future <List<GenreModel>>getGenres();

  Future <String> getBaseUrl();
}