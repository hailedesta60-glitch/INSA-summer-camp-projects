import 'package:http/http.dart' as http;
import '../constants/constant.dart';

class HttpClient {
  final http.Client _client;

  HttpClient({http.Client? client}) : _client = client ?? http.Client();

  Future<http.Response> get(String endpoint) {
    final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');

    return _client.get(url);
  }

  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) {
    final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');

    return _client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
  }

  void dispose() {
    _client.close();
  }
}