import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/feature/homescreen/presentation/pages/bottom_navigation.dart';
import 'package:yalgamers/feature/homescreen/presentation/pages/select_layout.dart';
import 'package:yalgamers/feature/login/google_auth/bloc/google_sign_in_bloc.dart';
import 'package:yalgamers/feature/login/google_auth/data/auth_repository_impl.dart';
import 'package:yalgamers/feature/login/google_auth/domain/repositories/google_sign_in_usecase.dart';
import 'package:yalgamers/feature/quest/data/repository/complete_task_repo.dart';
import 'package:yalgamers/feature/quest/data/repository/task_details_repo.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/project_bloc/project_bloc.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/save_task/save_task_bloc.dart';
import 'package:yalgamers/feature/quest/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:yalgamers/feature/quest/presentation/pages/task_screen.dart';
import 'package:yalgamers/feature/sign_up/presentation/bloc/signup_bloc.dart';
import 'package:yalgamers/feature/splash/presentation/pages/splash_screen.dart';
import 'package:yalgamers/feature/tournament/presentation/bloc/tournament_auth_bloc.dart';
import 'package:yalgamers/feature/tournament/presentation/pages/tournament_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authRepository = AuthRepositoryImpl();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GoogleSignInBloc(authrepo: authRepository),
        ),
        BlocProvider(
          create: (context) => SignupBloc(),
        ),
        BlocProvider(
          create: (context) => ProjectBloc(),
        ),
        BlocProvider(
            create: (context) => TaskBloc(repository: TaskRepository())),
        BlocProvider(
            create: (context) => SaveTaskBloc(taskService: SaveTaskService())),
        BlocProvider(create: (context) => TournamentAuthBloc())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const TournamentLayoutScreen());
      },
    );
  }
}
