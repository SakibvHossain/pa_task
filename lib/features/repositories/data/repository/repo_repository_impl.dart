import '../../../../core/network/network_info.dart';
import '../../domain/entities/repo_entity.dart';
import '../../domain/repository/repo_repository.dart';
import '../datasources/repo_local_ds.dart';
import '../datasources/repo_remote_ds.dart';

class RepoRepositoryImpl implements RepoRepository {
  final RepoRemoteDataSource remote;
  final RepoLocalDataSource local;
  final NetworkInfo networkInfo;

  RepoRepositoryImpl({
    required this.remote,
    required this.local,
    required this.networkInfo,
  });

  @override
  Future<List<RepoEntity>> getRepositories() async {
    if (await networkInfo.isConnected) {
      final repos = await remote.fetchRepositories();
      await local.cacheRepos(repos);
      return repos;
    } else {
      return local.getCachedRepos();
    }
  }
}