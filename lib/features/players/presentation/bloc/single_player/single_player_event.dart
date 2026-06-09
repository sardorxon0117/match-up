part of 'single_player_bloc.dart';

abstract class SinglePlayerEvent extends Equatable {
  SinglePlayerEvent();

  @override
  List<Object?> get props => [];
}

class SinglePlayerRequested extends SinglePlayerEvent {
  final int playerId;
  SinglePlayerRequested({required this.playerId});

  @override
  List<Object?> get props => [playerId];
}