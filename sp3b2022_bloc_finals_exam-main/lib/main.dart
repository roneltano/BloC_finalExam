import 'package:bloc_finals_exam/services/todos_themes.dart';
import 'package:bloc_finals_exam/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'blocs/switch_bloc/switch_bloc.dart';
import 'blocs/tasks_bloc/tasks_bloc.dart';
import 'services/app_router.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () {
      runApp(MyApp(
        appRouter: AppRouter(),
      ));
    },
    storage: storage,
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksBloc()),
        BlocProvider(create: (context) => SwitchBloc()),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.switchValue
                ? AppThemes.appThemeData[AppTheme.darkMode]!
                : AppThemes.appThemeData[AppTheme.lightMode]!,
            onGenerateRoute: appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
