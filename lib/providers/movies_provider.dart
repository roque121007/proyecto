import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_peliculas/models/model.dart';
import 'package:proyecto_peliculas/models/serach_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = 'f75c8b6efbddf53da4f286e1a81c3e65';
  final String _baseUrl = 'api.themoviedb.org';
  final String _languaje = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};

  int _popularpage = 0;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String segmento, [int page = 1]) async {
    var url = Uri.https(_baseUrl, segmento, {
      'api_key': _apiKey,
      'language': _languaje,
      'page': '$page',
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;
    //COmo se hace una modificacion y necesitamos redibujar widgets se utiliza notifyListeners
    notifyListeners(); //A todos los widgets que estan escuchando
  }

  getPopularMovies() async {
    _popularpage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularpage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) {
      return moviesCast[movieId]!;
    }

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditResponse = CreditResponse.fromJson(jsonData);

    moviesCast[movieId] = creditResponse.cast;
    return creditResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _languaje,
      'query': query,
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }
}
