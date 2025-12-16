import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/repo_bloc.dart';
import '../bloc/repo_event.dart';
import '../bloc/repo_state.dart';
import '../../../../core/utils/sorting_enum.dart';

class SortButton extends StatelessWidget {
  const SortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepoBloc, RepoState>(
      buildWhen: (previous, current) =>
      current is RepoLoaded || previous is RepoLoaded,
      builder: (context, state) {
        if (state is! RepoLoaded) {
          return const SizedBox.shrink();
        }

        final isStarSort = state.sort == SortType.stars;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                isStarSort ? 'Sorted by Stars' : 'Sorted by Updated',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(
                  isStarSort ? Icons.star : Icons.update,
                ),
                tooltip: 'Change sort order',
                onPressed: () {
                  context.read<RepoBloc>().add(ChangeSort());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
