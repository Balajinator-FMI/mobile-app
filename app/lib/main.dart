import 'package:app/feature/register/register_view.dart';
import 'package:app/static/dependency_injection.dart';
import 'package:app/storage/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stacked_services/stacked_services.dart';

import 'feature/chat/chat_view.dart';
import 'feature/home/home_view.dart';
import 'feature/search/search_result_view.dart';
import 'feature/search/search_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  DependencyInjection.configure();

  final initialRoute = await _getInitialRoute();

  runApp(MyApp(initialRoute: initialRoute));
}

Future<String> _getInitialRoute() async {
  final userStorage = DependencyInjection.getIt<UserSecureStorage>();
  final hasUserId = await userStorage.hasUserId();

  if (!hasUserId) {
    return 'home';
  }

  return 'home';
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({required this.initialRoute, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      navigatorKey: StackedService.navigatorKey,
      initialRoute: initialRoute,
      routes: {
        'register': (context) => RegisterView(),
        'home': (context) => HomeView(),
        'search': (context) => const SearchView(),
        'search-result': (context) => const SearchResultView(),
        'chat': (context) => const ChatView(),
      },
    );
  }
}
