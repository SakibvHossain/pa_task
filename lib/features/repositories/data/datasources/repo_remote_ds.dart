import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/network_request.dart';
import '../models/repo_model.dart';

abstract class RepoRemoteDataSource {
  Future<List<RepoModel>> fetchRepositories();
}

class RepoRemoteDataSourceImpl implements RepoRemoteDataSource {
  final NetworkRequest network;

  RepoRemoteDataSourceImpl(this.network);

  @override
  Future<List<RepoModel>> fetchRepositories() async {
    final response =
    await network.get(ApiConstants.searchFlutterRepos);

    final items = response.data['items'] as List;
    return items.map((e) => RepoModel.fromJson(e)).toList();
  }
}
