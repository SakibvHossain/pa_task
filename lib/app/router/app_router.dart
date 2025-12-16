import 'package:go_router/go_router.dart';
import 'package:pa_task/app/router/app_route_names.dart';
import 'package:pa_task/app/router/app_route_paths.dart';
import 'package:pa_task/features/repositories/presentation/pages/detail_page.dart';
import 'package:pa_task/features/repositories/presentation/pages/home_page.dart';
import '../../features/repositories/domain/entities/repo_entity.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: AppRoutePaths.homeRoutePath,
  routes: [
    GoRoute(
      path: AppRoutePaths.homeRoutePath,
      name: AppRouteNames.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutePaths.detailsRoutePath,
      name: AppRouteNames.details,
      builder: (context, state) {
        final repo = state.extra as RepoEntity;
        return DetailPage(repo: repo);
      },
    ),
  ],
);


