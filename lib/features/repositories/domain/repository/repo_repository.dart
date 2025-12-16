import '../entities/repo_entity.dart';

abstract class RepoRepository {
  Future<List<RepoEntity>> getRepositories();
}
