import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie/domain/hive/favourite_list.dart';
import 'package:movie/domain/hive/hive_boxes.dart';
import 'package:movie/movie_app.dart';


Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  await Hive.initFlutter();
  Hive.registerAdapter(FavouriteListAdapter());

  await Hive.openBox<FavouriteList>(HiveBoxes.favouriteBox);
  await dotenv.load(fileName: '.env');

  runApp(
    const MovieApp(),
  );
}
