import 'dart:async';
import 'dart:convert';

import 'package:app_services/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = '4eba175e781bf459b35804b08ad9461a';
  String _url = 'api.themoviedb.org';
  String _language = 'en-EN';

  bool _cargando = false;
  List<Movie> _populares = [];
  int _popularesPage = 0;
  // Top
  List<Movie> _toppopulares = [];
  int _toppopularesPage = 0;

  final _popularesStreanController = StreamController<List<Movie>>.broadcast();
  final _toppopularesStreanController =
      StreamController<List<Movie>>.broadcast();

  Stream<List<Movie>> get popularesStream => _popularesStreanController.stream;
  Function(List<Movie>) get popularesSink =>
      _popularesStreanController.sink.add;

  //Top
  Stream<List<Movie>> get toppopularesStream =>
      _toppopularesStreanController.stream;
  Function(List<Movie>) get toppopularesSink =>
      _toppopularesStreanController.sink.add;

  void disposeStreams() {
    _popularesStreanController.close();
    _toppopularesStreanController.close();
  }

  // void topdisposeStreams() {

  // }

  Future<List<Movie>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;
    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    //print(decodedData["results"]);

    final movies = Movies.fromJsonArray(decodedData["results"]).items;
    _populares.addAll(movies);
    popularesSink(_populares);

    _cargando = false;
    return movies;
  }

  Future<List<Movie>> getTopPopulares() async {
    if (_cargando) return [];
    _cargando = true;
    _toppopularesPage++;

    final url = Uri.https(_url, '3/trending/all/day', {
      'api_key': _apiKey,
      'language': _language,
      'page': _toppopularesPage.toString()
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    //print("Respuesta de Top Method");
    //print(decodedData["results"]);

    final topmovies = Movies.fromJsonArray(decodedData["results"]).items;
    _toppopulares.addAll(topmovies);
    toppopularesSink(_toppopulares);

    _cargando = false;
    return topmovies;
  }
}
