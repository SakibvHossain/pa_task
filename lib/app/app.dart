import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/network/dio_client.dart';
import '../core/network/network_info_impl.dart';
import '../core/network/network_request.dart';
import '../features/repositories/data/datasources/repo_local_ds.dart';
import '../features/repositories/data/datasources/repo_remote_ds.dart';
import '../features/repositories/data/repository/repo_repository_impl.dart';
import '../features/repositories/domain/usecases/get_repositories.dart';
import '../features/repositories/presentation/bloc/repo_bloc.dart';
import '../features/repositories/presentation/bloc/repo_event.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';
import 'theme/theme_cubit.dart';

class PATask extends StatelessWidget {
  const PATask({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //Theme
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),

        //Repositories (GLOBAL)
        BlocProvider<RepoBloc>(
          create: (_) => RepoBloc(
            GetRepositories(
              RepoRepositoryImpl(
                remote: RepoRemoteDataSourceImpl(
                  NetworkRequest(DioClient.create()),
                ),
                local: RepoLocalDataSourceImpl(),
                networkInfo: NetworkInfoImpl(Connectivity()),
              ),
            ),
          )..add(FetchRepos()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Pioneer Alpha Interview Task',

            // Themes
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,

            // Routing
            routerConfig: goRouter,
          );
        },
      ),
    );
  }
}

