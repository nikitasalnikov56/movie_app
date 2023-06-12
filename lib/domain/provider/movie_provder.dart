import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie/domain/api/api.dart';
import 'package:movie/domain/hive/favourite_list.dart';
import 'package:movie/domain/hive/hive_boxes.dart';
import 'package:movie/domain/json_convertors/movies.dart';
import 'package:movie/domain/json_convertors/popular.dart';
import 'package:movie/domain/json_convertors/search_movie.dart';


class MovieProvider extends ChangeNotifier {
  Movies? _movies;
  Movies? get movies => _movies;
  final String backgroundPath = 'https://image.tmdb.org/t/p/w500';

  Popular? popularFilms;

  SearchMovie? search;
  TextEditingController searchController = TextEditingController();

  Future<Movies?> setUp({String? lang}) async {
    _movies = await Api.getMovies(lang: lang ?? 'ru');
    popularFilms = await Api.getPopular(lang: lang ?? 'ru');
    search = await Api.searchMovie(movie: 'Avatar');
    // searchMovie().then(
    //   (value) => searchController.clear(),
    // );

    setCurrentBg();
    return _movies;
  }

  Future<void> searchMovie() async {
    try {
      var movieName = searchController.text;
      if (movieName.isEmpty) {
        search = await Api.searchMovie(movie: 'Avatar');
      } else {
        search = await Api.searchMovie(movie: movieName);
      }
    } catch (e) {
      var movieName = searchController.text;
      if (movieName.isEmpty) {
        search = await Api.searchMovie(movie: 'Avatar');
      } else {
        search = await Api.searchMovie(movie: movieName);
      }
    }

    notifyListeners();
  }

  Widget imageWidget(int index) {
    if (search?.search?[index].poster != "N/A" &&
        search?.search?[index].poster != null) {
      return Image.network(
        '${search?.search?[index].poster}',
        fit: BoxFit.cover,
      );
    } else {
      return Image.network(
        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png',
        fit: BoxFit.cover,
      );
    }
  }
  /* изменение заднего фона */

  String currentBg =
      'https://upload.wikimedia.org/wikipedia/ru/thumb/7/77/%D0%94%D0%BE%D0%BA%D1%82%D0%BE%D1%80_%D0%A1%D1%82%D1%80%D1%8D%D0%BD%D0%B4%D0%B6_%D0%92_%D0%BC%D1%83%D0%BB%D1%8C%D1%82%D0%B8%D0%B2%D1%81%D0%B5%D0%BB%D0%B5%D0%BD%D0%BD%D0%BE%D0%B9_%D0%B1%D0%B5%D0%B7%D1%83%D0%BC%D0%B8%D1%8F_%D1%82%D0%B8%D0%B7%D0%B5%D1%80_%D0%BF%D0%BE%D1%81%D1%82%D0%B5%D1%80.jpeg/800px-%D0%94%D0%BE%D0%BA%D1%82%D0%BE%D1%80_%D0%A1%D1%82%D1%80%D1%8D%D0%BD%D0%B4%D0%B6_%D0%92_%D0%BC%D1%83%D0%BB%D1%8C%D1%82%D0%B8%D0%B2%D1%81%D0%B5%D0%BB%D0%B5%D0%BD%D0%BD%D0%BE%D0%B9_%D0%B1%D0%B5%D0%B7%D1%83%D0%BC%D0%B8%D1%8F_%D1%82%D0%B8%D0%B7%D0%B5%D1%80_%D0%BF%D0%BE%D1%81%D1%82%D0%B5%D1%80.jpeg';

  Future<String> setCurrentBg() async {
    currentBg = backgroundPath + (movies?.results?[0].backdropPath ?? 'Error');
    return currentBg;
  }

  Future<void> setFavourite(BuildContext context, int index) async {
    var box = Hive.box<FavouriteList>(HiveBoxes.favouriteBox);

    box
        .add(
          FavouriteList(
            '${movies?.results?[index].originalTitle}',
            '$backgroundPath${movies?.results?[index].backdropPath}',
            '${movies?.results?[index].overview}',
          ),
        )
        .then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                'Кино ${movies?.results?[index].originalTitle} добавлен в избранное',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
        );
  }

  Future<void> setFavouritePopular(BuildContext context, int index) async {
    var box = Hive.box<FavouriteList>(HiveBoxes.favouriteBox);

    box
        .add(
          FavouriteList(
            '${popularFilms?.results?[index].originalTitle}',
            '$backgroundPath${popularFilms?.results?[index].backdropPath}',
            '${popularFilms?.results?[index].overview}',
          ),
        )
        .then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                'Кино ${popularFilms?.results?[index].originalTitle} добавлен в избранное',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
        );
  }

  Future<void> setFavouriteSearch(BuildContext context, int index) async {
    var box = Hive.box<FavouriteList>(HiveBoxes.favouriteBox);

    String setPoster() {
      if (search?.search?[index].poster != "N/A" &&
          search?.search?[index].poster != null) {
        return '${search?.search?[index].poster}';
      } else {
        return 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png';
      }
    }

    box
        .add(
          FavouriteList(
            '${search?.search?[index].title}',
            setPoster(),
            '${search?.search?[index].type}',
          ),
        )
        .then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                'Кино ${search?.search?[index].title} добавлен в избранное',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
        );
  }

  void deleteMovie(int index) {
    var box = Hive.box<FavouriteList>(HiveBoxes.favouriteBox);

    box.deleteAt(index);
  }
}
