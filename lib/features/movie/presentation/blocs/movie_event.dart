part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMoviesEvent extends MovieEvent{}

class MovieInitialStateEvent extends MovieEvent{}

class ShowErrorMessageEvent extends MovieEvent{
  final String errorMessage;

  ShowErrorMessageEvent(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class SearchMovieEvent extends MovieEvent{
  final String query;

  SearchMovieEvent(this.query);

  @override
  List<Object> get props => [query];
}