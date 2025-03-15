import 'package:app/feature/register/register_view.dart';
import 'package:app/static/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'feature/chat/chat_view.dart';
import 'feature/home/home_view.dart';
import 'feature/search/search_result_view.dart';
import 'feature/search/search_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  DependencyInjection.configure();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      initialRoute: 'register',
      routes: {
        'register': (context) => const RegisterView(),
        'home': (context) => const HomeView(),
        'search': (context) => const SearchView(),
        'search-result': (context) => const SearchResultView(),
        'chat': (context) => const ChatView(),
      },
    );
  }
}