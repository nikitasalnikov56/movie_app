
import 'package:flutter/material.dart';
import 'package:movie/domain/provider/movie_provder.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
      child: const Column(
        children:  [
          ExplorePageAppBar(),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: ListWidget(),
          ),
        ],
      ),
    );
  }
}

class ExplorePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ExplorePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieProvider>();
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 320,
            child: TextFormField(
              controller: model.searchController,
              cursorColor: const Color.fromARGB(169, 122, 122, 122),
              decoration: InputDecoration(
                fillColor: const Color.fromARGB(169, 179, 182, 179),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(26),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: model.searchMovie,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => throw UnimplementedError();
}

class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieProvider>();

    

    return GridView.builder(
      padding: const EdgeInsets.all(0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        mainAxisExtent: 280,
      ),
      itemCount: model.search?.search?.length,
      itemBuilder: (context, index) {
        return InkWell(
          onDoubleTap: () {
            model.setFavouriteSearch(context, index);
          },
          child:
              Card(
            child: model.imageWidget(index),
          ),
        );
      },
    );
  }
}
