import 'package:flutter/material.dart';
import 'package:movie/domain/provider/movie_provder.dart';
import 'package:provider/provider.dart';

class TopNewMoviesPage extends StatelessWidget {
  const TopNewMoviesPage({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF000000),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF000000),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const GridViewWidget(),
    );
  }
}

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MovieProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: model.movies?.results?.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          mainAxisExtent: 280,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onDoubleTap: () {
              model.setFavourite(context, index);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      '${model.backgroundPath}${model.movies?.results?[index].posterPath}',
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Positioned(
                    left: 15,
                    top: 15,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red,
                      ),
                      child: Text(
                        '${model.movies?.results?[index].voteAverage}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
