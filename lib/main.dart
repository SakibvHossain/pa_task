import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pa_task/app/app.dart';
import 'app/observer/app_bloc_observer.dart';
import 'core/utils/hive_boxes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HiveBoxes.repositories);
  Bloc.observer = AppBlocObserver();
  runApp(const PATask());
}
