import 'package:get_it/get_it.dart';
import 'package:movieapp/core/request.dart';
import 'package:movieapp/data/movie_repository.dart';
import 'package:movieapp/data/repository/movie_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;
Future<void> setUpServiceLocator() async {
  //repositories
  serviceLocator.registerFactory<MovieRepository>(() => MovieRepositoryImpl());

  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerFactory<SharedPreferences>(() => sharedPreferences);
  serviceLocator.registerSingleton<Request>(Request());
}
