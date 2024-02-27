import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/bloc/movie/movie_bloc.dart';
import 'package:movieapp/bloc/review/review_bloc.dart';
import 'package:movieapp/bloc/video/video_bloc.dart';
import 'package:movieapp/core/request.dart';
import 'package:movieapp/core/service_locator.dart';
import 'package:movieapp/ui/main/home_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await AppPathProvider.initPath();
  await setUpServiceLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MovieBloc(),
        ),
        BlocProvider(
          create: (_) => ReviewBloc(),
        ),
        BlocProvider(
          create: (_) => VideoBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        supportedLocales: const [
          Locale('en', ''),
        ],
        home: const HomeScreen(),
      ),
    );
  }
}
