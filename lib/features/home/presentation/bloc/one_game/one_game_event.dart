part of 'one_game_bloc.dart';

abstract class OneGameEvent extends Equatable {
  OneGameEvent();

  @override
  List<Object?> get props => [];
}

class OneGameRequested extends OneGameEvent {
  final int id;

  OneGameRequested({required this.id});

  @override
  List<Object?> get props => [id];
}