import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../bloc/repo_bloc.dart';
import '../bloc/repo_event.dart';
import '../bloc/repo_state.dart';
import '../widgets/repo_tile.dart';
import '../widgets/sort_button.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../widgets/repo_tile_skeleton.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Repositories')),
      body: BlocBuilder<RepoBloc, RepoState>(
        builder: (context, state) {
          if (state is RepoLoading) {
            return Skeletonizer(
              enabled: true,
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (_, __) => const RepoTileSkeleton(),
              ),
            );
          }

          if (state is RepoLoaded ||
              state is RepoRefreshing ||
              state is RepoRefreshSlow) {
            final repos = state is RepoLoaded
                ? state.repos
                : (state as dynamic).currentRepos;

            return Stack(
              children: [
                RefreshIndicator(
                    onRefresh: () {
                      final completer = Completer<void>();
                      context.read<RepoBloc>().add(RefreshRepos(completer));
                      return completer.future;
                    },
                  child: Column(
                    children: [
                      const SortButton(),
                      Expanded(
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: repos.length,
                          itemBuilder: (_, i) =>
                              RepoTile(repo: repos[i]),
                        ),
                      ),
                    ],
                  ),
                ),

                //* LOTTIE ONLY DURING SLOW REFRESH
                if (state is RepoRefreshSlow)
                  Center(
                    child: Lottie.asset(
                      'assets/lottie/running_cat.json',
                      width: 160,
                    ),
                  ),
              ],
            );
          }

          if (state is RepoError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}




