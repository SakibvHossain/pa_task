import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pa_task/app/router/app_route_paths.dart';
import 'package:pa_task/features/repositories/presentation/widgets/repo_avatar.dart';
import '../../domain/entities/repo_entity.dart';
import '../../../../core/utils/date_formatter.dart';


class RepoTile extends StatelessWidget {
  final RepoEntity repo;

  const RepoTile({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: RepoAvatar(url: repo.ownerAvatar),
      title: Text(
        repo.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(repo.ownerName),
          const SizedBox(height: 4),
          Text(
            '⭐ ${repo.stars} • Updated ${DateFormatter.format(repo.updatedAt)}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        context.go(
          AppRoutePaths.detailsRoutePath,
          extra: repo,
        );
      },
    );
  }
}

