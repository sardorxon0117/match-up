import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/league/domain/entities/one_league.dart';
import 'package:matchup/features/league/domain/repository/league_repository.dart';

class GetLeagueUseCase {
  final LeagueRepository repository;

  GetLeagueUseCase(this.repository);

  Future<Either<Failure, Leaguee>> call({required int id}) async {
    return await repository.getLeague(id: id);
  }
}