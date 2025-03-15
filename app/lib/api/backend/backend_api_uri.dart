import 'package:flutter_dotenv/flutter_dotenv.dart';

class BackendApiUri {
  final String _baseUrl = dotenv.env['BACKEND_API_BASE_URL']!;

  Uri registerUser() => Uri.parse('$_baseUrl/user/register');
}
