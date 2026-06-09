import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/league/domain/entities/all_leagues.dart';
import 'package:matchup/features/league/domain/repository/league_repository.dart';

class GetAllLeaguesUseCase {
  final LeagueRepository repository;

  GetAllLeaguesUseCase(this.repository);

  Future<Either<Failure, Leaguees>> call() async {
    return await repository.getAllLeagues();
  }
}