import 'package:the_movie_db/config/constants.dart';
import 'package:the_movie_db/core/data/data_sources/local_data_source.dart';
import 'package:the_movie_db/core/data/models/genre_model.dart';
import 'package:the_movie_db/features/movie/data/data_sources/movie_data_source.dart';
import 'package:the_movie_db/features/movie/data/models/movie_response_model.dart';
import 'package:the_movie_db/features/movie/domain/repositories/i_movie_repository.dart';

class MovieRepository implements IMovieRepository{

  final MovieDataSource _movieDataSource = MovieDataSource();
  final LocalDataSource _localDataSource = LocalDataSource();

  @override
  Future <(MovieResponseModel,bool)>getMovies(int page) async {
    try{
      final data = await _movieDataSource.getMovies(page);
      return (MovieResponseModel.fromJson(data),false);
    }catch(e){
      final movieResponse = await _localDataSource.read(Constants.movieResponseKey);
      if(movieResponse != null){
        return (MovieResponseModel.movieResponseFromString(movieResponse),true);
      }
      throw(Constants.generalError);
    }
  }

  @override
  Future <List<GenreModel>>getGenres() async {
    try{
      final data = await _movieDataSource.getGenres();
      final genres = GenreModel.genreModelListFromListMap(data);
      await _localDataSource.write(key: Constants.genresKey, value: GenreModel.genreModelListToJson(genres));
      return genres;
    }catch(e){
      final data = await _localDataSource.read(Constants.genresKey);
      if(data != null){
        return GenreModel.genreModelListFromString(data);
      }
      throw(Constants.generalError);
    }

  }

  @override
  Future <String> getBaseUrl() async {
    try{
      final data = await _movieDataSource.getConfig();
      if (data["secure_base_url"] != null){
        await _localDataSource.write(key: Constants.secureBaseUrlKey, value: data["secure_base_url"]);
      }
      return data["secure_base_url"];
    }catch(e){
      final url = await _localDataSource.read(Constants.secureBaseUrlKey);
      if(url != null){
        return url;
      }
      throw(Constants.generalError);
    }

  }

  @override
  Future<void> saveMovies(MovieResponseModel movies) async {
    final jsonString  = MovieResponseModel.responseToString(movies);
    await _localDataSource.write(key: Constants.movieResponseKey, value: jsonString);
  }

  
}