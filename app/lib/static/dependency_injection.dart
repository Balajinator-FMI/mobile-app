import 'package:app/api/backend/backend_api_uri.dart';
import 'package:app/api/backend/user_repository.dart';
import 'package:app/api/backend/user_service.dart';
import 'package:app/api/google-maps/google_maps_api_service.dart';
import 'package:app/api/google-maps/google_maps_api_uri.dart';
import 'package:app/storage/user_local_storage.dart';
import 'package:app/storage/user_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

class DependencyInjection {
  DependencyInjection._();

  static GetIt getIt = GetIt.instance;

  static void configure() {
    getIt.registerSingleton<NavigationService>(NavigationService());

    getIt.registerSingleton<UserSecureStorage>(UserSecureStorage());
    getIt.registerSingleton<UserLocalStorage>(UserLocalStorage());

    getIt.registerSingleton<BackendApiUri>(BackendApiUri());
    getIt.registerSingleton<UserService>(UserService());
    getIt.registerSingleton<UserRepository>(UserRepository());

    getIt.registerSingleton<GoogleMapsApiUri>(GoogleMapsApiUri());
    getIt.registerSingleton<GoogleMapsApiService>(GoogleMapsApiService());
  }
}
