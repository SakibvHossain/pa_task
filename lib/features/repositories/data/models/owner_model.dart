class OwnerModel {
  final String name;
  final String avatar;

  OwnerModel({
    required this.name,
    required this.avatar,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      name: json['login'],
      avatar: json['avatar_url'],
    );
  }
}
