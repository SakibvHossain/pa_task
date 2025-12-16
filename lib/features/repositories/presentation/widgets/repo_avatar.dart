import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RepoAvatar extends StatelessWidget {
  final String url;
  final double radius;

  const RepoAvatar({
    super.key,
    required this.url,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return CircleAvatar(
        radius: radius,
        child: const Icon(Icons.person),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade200,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: url,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          placeholder: (_, __) => const SizedBox.shrink(),
          errorWidget: (_, __, ___) =>
          const Icon(Icons.person),
        ),
      ),
    );
  }
}
