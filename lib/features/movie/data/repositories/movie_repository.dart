import 'package:the_movie_db/core/data/models/genre_model.dart';
import 'package:the_movie_db/features/movie/data/data_sources/movie_data_source.dart';
import 'package:the_movie_db/features/movie/data/models/movie_response_model.dart';
import 'package:the_movie_db/features/movie/domain/repositories/i_movie_repository.dart';

class MovieRepository implements IMovieRepository{

  final MovieDataSource _movieDataSource = MovieDataSource();

  @override
  Future <MovieResponseModel>getMovies(int page) async {
    final data = await _movieDataSource.getMovies(page);
    final movieResponse = MovieResponseModel.fromJson(data);
    return movieResponse;
  }

  @override
  Future <List<GenreModel>>getGenres() async {
    final data = await _movieDataSource.getGenders();
    final movieResponse = GenreModel.genreModelListFromListMap(data);
    return movieResponse;
  }

  @override
  Future <String> getBaseUrl() async {
    final data = await _movieDataSource.getConfig();
    return data["secure_base_url"];
  }

}