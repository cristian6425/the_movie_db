import 'package:the_movie_db/core/utils/dio_petition.dart';

class MovieDataSource{

  Future<dynamic> getMovies(int page) async {
   final response = await petition.get('movie/upcoming?language=en-US&page=${page.toString()}');
   if (response.statusCode == 200) return response.data;
   return null;
  }

  Future<dynamic> getGenres() async {
    final response = await petition.get('genre/movie/list?language=en');
    if (response.statusCode == 200) return response.data["genres"];
    return null;
  }

  Future<dynamic> getConfig() async {
    final response = await petition.get('configuration');
    if (response.statusCode == 200) return response.data["images"];
    return null;
  }
}