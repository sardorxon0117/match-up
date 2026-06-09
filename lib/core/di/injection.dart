import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:matchup/core/network/dio_client.dart';
import 'package:matchup/core/storage/hive_service.dart';
import 'package:matchup/features/home/data/datasource/game_remoute_datasource.dart';
import 'package:matchup/features/home/data/repository/game_repository_imple.dart';
import 'package:matchup/features/home/domain/repository/game_repository.dart';
import 'package:matchup/features/home/domain/usecases/get_all_games_by_date_usecase.dart';
import 'package:matchup/features/home/domain/usecases/get_all_games_by_league_usecase.dart';
import 'package:matchup/features/home/domain/usecases/get_game_usecase.dart';
import 'package:matchup/features/home/presentation/bloc/date_games/date_games_bloc.dart';
import 'package:matchup/features/home/presentation/bloc/league_games/league_games_bloc.dart';
import 'package:matchup/features/home/presentation/bloc/one_game/one_game_bloc.dart';
import 'package:matchup/features/league/data/datasource/league_remoute_datasource.dart';
import 'package:matchup/features/league/data/repository/league_repository_imple.dart';
import 'package:matchup/features/league/domain/repository/league_repository.dart';
import 'package:matchup/features/league/domain/usecases/get_all_leagues_usecase.dart';
import 'package:matchup/features/league/domain/usecases/get_league_usecase.dart';
import 'package:matchup/features/league/domain/usecases/search_leagues_usecase.dart';
import 'package:matchup/features/league/presentation/bloc/all_leagues/all_leagues_bloc.dart';
import 'package:matchup/features/league/presentation/bloc/one_league/one_league_bloc.dart';
import 'package:matchup/features/players/data/datasource/players_remoute_datasource.dart';
import 'package:matchup/features/players/data/repository/players_repository_imple.dart';
import 'package:matchup/features/players/domain/repository/players_repository.dart';
import 'package:matchup/features/players/domain/usecases/get_all_players_usecase.dart';
import 'package:matchup/features/players/domain/usecases/get_player_team_usecase.dart';
import 'package:matchup/features/players/domain/usecases/get_single_player_usecase.dart';
import 'package:matchup/features/players/domain/usecases/search_players_usecase.dart';
import 'package:matchup/features/players/presentation/bloc/all_players/all_players_bloc.dart';
import 'package:matchup/features/players/presentation/bloc/player_teams/player_teams_bloc.dart';
import 'package:matchup/features/players/presentation/bloc/single_player/single_player_bloc.dart';
import 'package:matchup/features/standing/data/datasource/standing_romoute_datasorce.dart';
import 'package:matchup/features/standing/data/repository/standing_repository_imple.dart';
import 'package:matchup/features/standing/domain/repository/standing_repository.dart';
import 'package:matchup/features/standing/domain/usecase/get_standings_usecase.dart';
import 'package:matchup/features/standing/presentation/bloc/standing/standing_bloc.dart';
import 'package:matchup/features/team/data/datasource/team_remoute_datasource.dart';
import 'package:matchup/features/team/data/repository/team_repository_imple.dart';
import 'package:matchup/features/team/domain/repository/team_repository.dart';
import 'package:matchup/features/team/domain/usecases/get_team_usecase.dart';
import 'package:matchup/features/team/presentation/bloc/team_profile/team_profile_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerSingleton<HiveService>(HiveService());
  getIt.registerSingleton<Dio>(DioClient.createDio());

  // ========== Games ==========

  getIt.registerSingleton<GameRemouteDatasource>(
    GameRemouteDatasourceImple(dio: getIt<Dio>()),
  );

  getIt.registerSingleton<GameRepository>(
    GameRepositoryImple(gameRemouteDatasource: getIt<GameRemouteDatasource>()),
  );

  getIt.registerSingleton<GetAllGamesByDateUsecase>(
    GetAllGamesByDateUsecase(getIt<GameRepository>()),
  );

  getIt.registerSingleton<GetAllGamesByLeagueUsecase>(
    GetAllGamesByLeagueUsecase(getIt<GameRepository>()),
  );

  getIt.registerFactory<DateGamesBloc>(
    () => DateGamesBloc(
      getAllGamesByDateUsecase: getIt<GetAllGamesByDateUsecase>(),
    ),
  );

  getIt.registerFactory<LeagueGamesBloc>(
    () => LeagueGamesBloc(
      getAllGamesByLeagueUsecase: getIt<GetAllGamesByLeagueUsecase>(),
    ),
  );

  getIt.registerSingleton<GetGameUseCase>(
    GetGameUseCase(getIt<GameRepository>()),
  );

  getIt.registerFactory<OneGameBloc>(
    () => OneGameBloc(getGameUseCase: getIt<GetGameUseCase>()),
  );

  // ========== Leagues ==========

  getIt.registerSingleton<LeagueRemouteDatasource>(
    LeagueRemouteDatasourceImple(dio: getIt<Dio>()),
  );

  getIt.registerSingleton<LeagueRepository>(
    LeagueRepositoryImple(
      leagueRemouteDatasource: getIt<LeagueRemouteDatasource>(),
    ),
  );

  getIt.registerSingleton<GetAllLeaguesUseCase>(
    GetAllLeaguesUseCase(getIt<LeagueRepository>()),
  );

  getIt.registerSingleton<GetLeagueUseCase>(
    GetLeagueUseCase(getIt<LeagueRepository>()),
  );

  getIt.registerSingleton<SearchLeaguesUseCase>(
    SearchLeaguesUseCase(getIt<LeagueRepository>()),
  );

  getIt.registerFactory<AllLeaguesBloc>(
    () => AllLeaguesBloc(
      getAllLeaguesUseCase: getIt<GetAllLeaguesUseCase>(),
      searchLeaguesUseCase: getIt<SearchLeaguesUseCase>(),
    ),
  );

  getIt.registerFactory<OneLeagueBloc>(
    () => OneLeagueBloc(getLeagueUseCase: getIt<GetLeagueUseCase>()),
  );

  // Standing ======================

  getIt.registerSingleton<StandingRomouteDatasorce>(
    StandingRomouteDatasorceImple(dio: getIt<Dio>()),
  );

  getIt.registerSingleton<StandingRepository>(
    StandingRepositoryImple(
      standingRomouteDatasorce: getIt<StandingRomouteDatasorce>(),
    ),
  );

  getIt.registerSingleton<GetStandingsUsecase>(
    GetStandingsUsecase(getIt<StandingRepository>()),
  );

  getIt.registerFactory<StandingBloc>(
    () => StandingBloc(getStandingsUsecase: getIt<GetStandingsUsecase>()),
  );

  //   Players ===============

  getIt.registerSingleton<PlayersRemouteDatasource>(
    PlayersRemouteDatasourceImple(dio: getIt<Dio>()),
  );

  getIt.registerSingleton<PlayersRepository>(
    PlayersRepositoryImple(
      playersRemouteDatasource: getIt<PlayersRemouteDatasource>(),
    ),
  );

  getIt.registerSingleton<GetAllPlayersUsecase>(
    GetAllPlayersUsecase(getIt<PlayersRepository>()),
  );

  getIt.registerSingleton<GetSinglePlayerUsecase>(
    GetSinglePlayerUsecase(getIt<PlayersRepository>()),
  );

  getIt.registerSingleton<SearchPlayersUsecase>(
    SearchPlayersUsecase(getIt<PlayersRepository>()),
  );

  getIt.registerSingleton<GetPlayerTeamUsecase>(
    GetPlayerTeamUsecase(getIt<PlayersRepository>()),
  );

  getIt.registerFactory<AllPlayersBloc>(
    () => AllPlayersBloc(
      getAllPlayersUsecase: getIt<GetAllPlayersUsecase>(),
      searchPlayersUsecase: getIt<SearchPlayersUsecase>(),
    ),
  );

  getIt.registerFactory<SinglePlayerBloc>(
        () => SinglePlayerBloc(
      getSinglePlayerUsecase: getIt<GetSinglePlayerUsecase>(),
    ),
  );

  getIt.registerFactory<PlayerTeamsBloc>(
        () => PlayerTeamsBloc(
      getPlayerTeamUsecase: getIt<GetPlayerTeamUsecase>(),
    ),
  );


  // Team

  getIt.registerSingleton<TeamRemouteDatasource>(
    TeamRemouteDatasourceImple(dio: getIt<Dio>()),
  );

  getIt.registerSingleton<TeamRepository>(
    TeamRepositoryImple(
      teamRemouteDatasource: getIt<TeamRemouteDatasource>(),
    ),
  );

  getIt.registerSingleton<GetTeamUsecase>(
    GetTeamUsecase(getIt<TeamRepository>()),
  );

  getIt.registerFactory<TeamProfileBloc>(
        () => TeamProfileBloc(
      getTeamUsecase: getIt<GetTeamUsecase>(),
    ),
  );
}
