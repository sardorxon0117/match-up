import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/game.dart';
import '../repository/game_repository.dart';

class GetGameUseCase {
  final GameRepository repository;

  GetGameUseCase(this.repository);

  Future<Either<Failure, OneGame>> call({required int id}) async {
    return await repository.getGame(id: id);
  }
}