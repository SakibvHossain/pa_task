import '../../domain/entities/repo_entity.dart';
import 'owner_model.dart';

class RepoModel extends RepoEntity {
  RepoModel({
    required super.name,
    required super.ownerName,
    required super.ownerAvatar,
    required super.description,
    required super.stars,
    required super.updatedAt,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    final owner = OwnerModel.fromJson(json['owner']);

    return RepoModel(
      name: json['name'],
      ownerName: owner.name,
      ownerAvatar: owner.avatar,
      description: json['description'] ?? '',
      stars: json['stargazers_count'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'ownerName': ownerName,
    'ownerAvatar': ownerAvatar,
    'description': description,
    'stars': stars,
    'updatedAt': updatedAt,
  };

  factory RepoModel.fromCache(Map<String, dynamic> json) {
    return RepoModel(
      name: json['name'],
      ownerName: json['ownerName'],
      ownerAvatar: json['ownerAvatar'],
      description: json['description'],
      stars: json['stars'],
      updatedAt: json['updatedAt'],
    );
  }
}
