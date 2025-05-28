import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_peliculas/models/model.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = "f75c8b6efbddf53da4f286e1a81c3e65";
  String _baseUrl = "api.themoviedb.org";
  String _languaje = "es-ES";

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};
  int _popularPage = 0;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }
  Future<String> _getJsonData(String segmento, [int page = 1]) async {
    var url = Uri.https(_baseUrl, segmento, {
      'api_key': _apiKey,
      'languaje': _languaje,
      'page': '$page',
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData("3/movie/now_playing");
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData("3/movie/popular", _popularPage);

    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    final jsonData = await _getJsonData("3/movie/$movieId/credits");

    final creditResponse = CreditResponse.fromJson(jsonData);
    moviesCast[movieId] = creditResponse.cast;
    return creditResponse.cast;
  }
}
