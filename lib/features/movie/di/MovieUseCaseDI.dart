import 'package:the_movie_db/features/movie/data/repositories/movie_repository.dart';
import 'package:the_movie_db/features/movie/domain/use_cases/movie_use_case.dart';

class MovieUseCaseDi{

  MovieUseCase get movieUseCase => MovieUseCase(MovieRepository());

}

final movieUseCaseDi = MovieUseCaseDi();