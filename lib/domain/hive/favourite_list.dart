import 'package:hive_flutter/hive_flutter.dart';

part 'favourite_list.g.dart';

@HiveType(typeId: 0)
class FavouriteList {
  @HiveField(0)
  String? movieTitle;

  @HiveField(1)
  String? movieBg;

  @HiveField(2)
  String? movieOverview;
  
  FavouriteList(this.movieTitle, this.movieBg ,this.movieOverview);
}
