import '../entities/repo_entity.dart';
import '../repository/repo_repository.dart';

class GetRepositories {
  final RepoRepository repository;

  GetRepositories(this.repository);

  Future<List<RepoEntity>> call() {
    return repository.getRepositories();
  }
}
