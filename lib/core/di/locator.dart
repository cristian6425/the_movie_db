import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_db/features/movie/di/MovieUseCaseDI.dart';
import 'package:the_movie_db/features/movie/presentation/blocs/movie_bloc.dart';

class LocatorDi {
  static get instance => [
        BlocProvider(
          create: (_) => MovieBloc(movieUseCase: movieUseCaseDi.movieUseCase)..add(MovieInitialState()),
        )
      ];
}
