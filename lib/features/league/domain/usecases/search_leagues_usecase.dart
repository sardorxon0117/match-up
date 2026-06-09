import 'package:dartz/dartz.dart';
import 'package:matchup/core/errors/failures.dart';
import 'package:matchup/features/league/domain/entities/all_leagues.dart';
import 'package:matchup/features/league/domain/repository/league_repository.dart';

class SearchLeaguesUseCase {
  final LeagueRepository repository;

  SearchLeaguesUseCase(this.repository);

  Future<Either<Failure, Leaguees>> call({required String query}) async {
    return await repository.searchLeagues(query: query);
  }
}