part of 'date_games_bloc.dart';

abstract class DateGamesEvent extends Equatable {
  DateGamesEvent();

  @override
  List<Object?> get props => [];
}

class DateGamesRequested extends DateGamesEvent {
  final String date;

  DateGamesRequested({required this.date});

  @override
  List<Object?> get props => [date];
}