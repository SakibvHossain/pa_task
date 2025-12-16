class RepoEntity {
  final String name;
  final String ownerName;
  final String ownerAvatar;
  final String description;
  final int stars;
  final String updatedAt;

  RepoEntity({
    required this.name,
    required this.ownerName,
    required this.ownerAvatar,
    required this.description,
    required this.stars,
    required this.updatedAt,
  });
}
