import 'dart:async';

abstract class RepoEvent {}
class FetchRepos extends RepoEvent {} //For fetching the repos
class ChangeSort extends RepoEvent {} //For changing the sort
class RefreshRepos extends RepoEvent {
  final Completer<void> completer;

  RefreshRepos(this.completer);
}
 //Refresh and load lottie
