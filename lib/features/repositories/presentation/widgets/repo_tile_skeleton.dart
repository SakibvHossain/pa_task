import 'package:flutter/material.dart';
import '../../domain/entities/repo_entity.dart';
import 'repo_tile.dart';

class RepoTileSkeleton extends StatelessWidget {
  const RepoTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return RepoTile(
      repo: RepoEntity(
        name: 'Repository name',
        ownerName: 'Owner',
        ownerAvatar: '',
        description: 'Description',
        stars: 0,
        updatedAt: DateTime.now().toIso8601String(),
      ),
    );
  }
}
