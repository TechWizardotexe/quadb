import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/movie.dart';

class ApiService {
  Future<List<Movie>> fetchMovies(String query) async {
    try {
      final Uri url = Uri.parse('https://api.tvmaze.com/search/shows?q=$query');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        if (data is List && data.isNotEmpty && data.first is Map) {
          return data.map((item) {
            final Map<String, dynamic>? image = item['show']['image'];
            return Movie(
              title: item['show']['name'] ?? '',
              summary: item['show']['summary'] ?? '',
              imageUrl: image != null ? image['medium'] ?? '' : '',
            );
          }).toList();
        } else {
          throw Exception('Invalid data structure');
        }
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  fetchAllMovies() {}
}
