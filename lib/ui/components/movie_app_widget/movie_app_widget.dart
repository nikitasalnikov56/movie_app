import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:movie/domain/provider/movie_provder.dart';
import 'package:movie/ui/pages/top_new_movies_page/top_new_movies_page.dart';
import 'package:movie/ui/pages/top_release_page/top_release_page.dart';
import 'package:provider/provider.dart';

class MovieAppWidgets extends StatelessWidget {
  const MovieAppWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieProvider>();
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
                image: NetworkImage(
                  model.currentBg,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    model.movies?.results?[0].originalTitle ?? 'Error',
                    style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    model.movies?.results?[0].overview ?? 'Error',
                    style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        const SizedBox(
          height: 325,
          child: CardWidget(),
        ),
      ],
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = Provider.of<MovieProvider>(context);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        const TitleTopWidget(
          text: 'Top 10 Movies Whis Week',
        ),
        SizedBox(
          height: 180,
          child: InfiniteCarousel.builder(
            itemCount: 10,
            itemExtent: 150,
            center: true,
            anchor: 0.0,
            velocityFactor: 0.2,
            onIndexChanged: (index) {},
            // controller: controller,
            axisDirection: Axis.horizontal,
            loop: true,
            itemBuilder: (context, index, realIndex) {
              return Card(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          '${movies.backgroundPath}${movies.movies?.results?[index].posterPath}'),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const TitleTopWidget(
          text: 'New Releases',
        ),
        SizedBox(
          height: 180,
          child: InfiniteCarousel.builder(
            itemCount: 10,
            itemExtent: 150,
            center: true,
            anchor: 0.0,
            velocityFactor: 0.2,
            onIndexChanged: (index) {},
            // controller: controller,
            axisDirection: Axis.horizontal,
            loop: true,
            itemBuilder: (context, index, realIndex) {
              return Card(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          '${movies.backgroundPath}${movies.popularFilms?.results?[index].posterPath}'),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class TitleTopWidget extends StatelessWidget {
  const TitleTopWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          text,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                if (text == 'Top 10 Movies Whis Week') {
                  return TopNewMoviesPage(
                    text: text,
                  );
                } else {
                  return TopReleasePage(
                    text: text,
                  );
                }
              }),
            );
          },
          child: const Text(
            'See All',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.red),
          ),
        ),
      ],
    );
  }
}
