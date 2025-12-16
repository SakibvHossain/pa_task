import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/sorting_enum.dart';
import '../../domain/entities/repo_entity.dart';
import '../../domain/usecases/get_repositories.dart';
import 'repo_event.dart';
import 'repo_state.dart';

class RepoBloc extends Bloc<RepoEvent, RepoState> {
  final GetRepositories getRepositories;
  SortType _currentSort = SortType.stars;

  RepoBloc(this.getRepositories) : super(RepoLoading()) {
    on<FetchRepos>(_onFetch);
    on<ChangeSort>(_onSort);
    on<RefreshRepos>(_onRefresh);
  }

  Future<void> _onFetch(
      FetchRepos event,
      Emitter<RepoState> emit,
      ) async {
    emit(RepoLoading());
    try {
      final List<RepoEntity> repos = await getRepositories();
      emit(RepoLoaded(_sort(repos), _currentSort));
    } catch (e) {
      emit(RepoError(e.toString()));
    }
  }

  Future<void> _onRefresh(
      RefreshRepos event,
      Emitter<RepoState> emit,
      ) async {
    if (state is! RepoLoaded) {
      event.completer.complete();
      return;
    }

    final currentRepos = (state as RepoLoaded).repos;

    emit(RepoRefreshing(currentRepos));

    bool slowEmitted = false;

    // Slow refresh detector
    final timer = Timer(const Duration(milliseconds: 1), () {
      if (!isClosed && state is RepoRefreshing) {
        slowEmitted = true;
        emit(RepoRefreshSlow(currentRepos));
      }
    });

    try {
      final repos = await getRepositories();

      timer.cancel(); // stop slow detector
      emit(RepoLoaded(_sort(repos), _currentSort));
    } catch (_) {
      timer.cancel();
      emit(RepoLoaded(currentRepos, _currentSort));
    } finally {
      event.completer.complete(); // VERY IMPORTANT
    }
  }



  void _onSort(ChangeSort event, Emitter<RepoState> emit) {
    if (state is RepoLoaded) {
      _currentSort = _currentSort == SortType.stars
          ? SortType.updated
          : SortType.stars;

      final repos = (state as RepoLoaded).repos;
      emit(RepoLoaded(_sort(repos), _currentSort));
    }
  }

  // Fully type-safe sorting
  List<RepoEntity> _sort(List<RepoEntity> repos) {
    final sorted = List<RepoEntity>.from(repos);

    if (_currentSort == SortType.stars) {
      sorted.sort((a, b) => b.stars.compareTo(a.stars));
    } else {
      sorted.sort(
            (a, b) => b.updatedAt.compareTo(a.updatedAt),
      );
    }

    return sorted;
  }
}
