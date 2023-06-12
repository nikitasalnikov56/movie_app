import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie/domain/hive/favourite_list.dart';
import 'package:movie/domain/hive/hive_boxes.dart';
import 'package:movie/domain/provider/movie_provder.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My List',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ValueListenableBuilder<Box<FavouriteList>>(
                valueListenable: Hive.box<FavouriteList>(HiveBoxes.favouriteBox)
                    .listenable(),
                builder: (context, value, _) {
                  return GridView.builder(
                    itemCount: value.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      mainAxisExtent: 250,
                    ),
                    itemBuilder: (context, i) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                        color: Colors.blueGrey,
                        child: Stack(
                          children: [
                            GridTile(
                              // header: Padding(
                              //   padding: const EdgeInsets.only(
                              //       top: 25.0, left: 5, right: 5),
                              //   child: Text(
                              //     value.getAt(i)?.movieTitle ?? 'Error',
                              //     textAlign: TextAlign.center,
                              //     style: const TextStyle(
                              //       color: Color.fromARGB(255, 103, 255, 1),
                              //       fontSize: 16,
                              //       letterSpacing: 5,
                              //       overflow: TextOverflow.ellipsis,
                              //       fontWeight: FontWeight.w800,
                              //     ),
                              //   ),
                              // ),
                              footer: Padding(
                                padding: const EdgeInsets.only(bottom: 25.0),
                                child: Text(
                                  model.movies?.results?[i].releaseDate ??
                                      'Error',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  value.getAt(i)?.movieBg ?? 'Error',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: -5,
                              right: -5,
                              child: IconButton(
                                onPressed: () => model.deleteMovie(i),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
