import '../../domain/entities/repo_entity.dart';
import '../../../../core/utils/sorting_enum.dart';

abstract class RepoState {}

class RepoLoading extends RepoState {}

class RepoLoaded extends RepoState {
  final List<RepoEntity> repos;
  final SortType sort;

  RepoLoaded(this.repos, this.sort);
}

class RepoRefreshing extends RepoState {
  final List<RepoEntity> currentRepos;

  RepoRefreshing(this.currentRepos);
}

class RepoRefreshSlow extends RepoState {
  final List<RepoEntity> currentRepos;

  RepoRefreshSlow(this.currentRepos);
}

class RepoError extends RepoState {
  final String message;

  RepoError(this.message);
}
