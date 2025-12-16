import 'package:hive/hive.dart';
import '../../../../core/utils/hive_boxes.dart';
import '../models/repo_model.dart';

abstract class RepoLocalDataSource {
  Future<void> cacheRepos(List<RepoModel> repos);
  List<RepoModel> getCachedRepos();
}

class RepoLocalDataSourceImpl implements RepoLocalDataSource {
  @override
  Future<void> cacheRepos(List<RepoModel> repos) async {
    final box = await Hive.openBox(HiveBoxes.repositories);
    await box.put(
      'repos',
      repos.map((e) => e.toJson()).toList(),
    );
  }

  @override
  List<RepoModel> getCachedRepos() {
    final box = Hive.box(HiveBoxes.repositories);
    final cached = box.get('repos', defaultValue: []);
    return (cached as List)
        .map((e) => RepoModel.fromCache(Map<String, dynamic>.from(e)))
        .toList();
  }
}
