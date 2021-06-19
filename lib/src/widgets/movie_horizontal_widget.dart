import 'package:app_services/src/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontalWidget extends StatelessWidget {
  final List<Movie>? movies;
  final Function? nextPage;

  MovieHorizontalWidget({@required this.movies, @required this.nextPage});
  final _pageController = PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage!();
      }
    });

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
          pageSnapping: false,
          controller: _pageController,
          itemCount: movies!.length,
          itemBuilder: (context, position) => _createCard(movies![position])),
    );
  }

  Widget _createCard(Movie movie) {
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(movie.getPosterImage()),
                fit: BoxFit.cover,
                height: 160.0),
          ),
          SizedBox(height: 5.0),
          Text(
            movie.title != null ? movie.title! : "Lenguaje no Valido",
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
