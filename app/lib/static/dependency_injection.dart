import 'package:app/api/backend/backend_api_uri.dart';
import 'package:app/api/backend/user_repository.dart';
import 'package:app/api/backend/user_service.dart';
import 'package:app/util/user_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

class DependencyInjection {
  DependencyInjection._();

  static GetIt getIt = GetIt.instance;

  static void configure() {
    getIt.registerSingleton<NavigationService>(NavigationService());

    getIt.registerSingleton<UserStorage>(UserStorage());
    getIt.registerSingleton<BackendApiUri>(BackendApiUri());
    getIt.registerSingleton<UserService>(UserService());
    getIt.registerSingleton<UserRepository>(UserRepository());
  }
}
