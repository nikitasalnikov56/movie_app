import 'package:flutter/cupertino.dart';
import 'package:movie/domain/json_convertors/movies.dart';
import 'package:movie/domain/provider/movie_provder.dart';
import 'package:movie/ui/components/movie_app_widget/movie_app_widget.dart';
import 'package:provider/provider.dart';

class MovieDbBody extends StatelessWidget {
  const MovieDbBody({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Movies?>(
      future: Provider.of<MovieProvider>(context).setUp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const MovieAppWidgets();
        } else {
          return const CupertinoActivityIndicator.partiallyRevealed();
        }
      },
    );
  }
}
