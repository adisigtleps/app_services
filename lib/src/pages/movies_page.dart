import 'package:app_services/src/providers/movies_provider.dart';
import 'package:app_services/src/shared/preferences.dart';
import 'package:app_services/src/widgets/movie_horizontal_widget.dart';
import 'package:flutter/material.dart';

class MoviesPage extends StatelessWidget {
  final moviesProvider = MoviesProvider();
  final moviesProviderD = MoviesProvider();
  final preferences = Preferences();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopulares();
    moviesProviderD.getTopPopulares();

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        actions: [
          IconButton(onPressed: () => logout(context), icon: Icon(Icons.logout))
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text('Popular Movies'),
          _movies(),
          Divider(),
          Text('Top Rated'),
          _moviestop(),
        ],
      ),
    );
  }

  void logout(BuildContext context) {
    preferences.token = '';
    Navigator.pushReplacementNamed(context, 'login');
  }

  Widget _movies() {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 5.0),
          StreamBuilder(
              stream: moviesProvider.popularesStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MovieHorizontalWidget(
                      movies: snapshot.data,
                      nextPage: moviesProvider
                          .getPopulares); // Aqui estará la funcionalidad
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }

  Widget _moviestop() {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 5.0),
          StreamBuilder(
              stream: moviesProviderD.toppopularesStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MovieHorizontalWidget(
                      movies: snapshot.data,
                      nextPage: moviesProviderD
                          .getTopPopulares); // Aqui estará la funcionalidad
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }
}
