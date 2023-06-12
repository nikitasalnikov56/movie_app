import 'package:flutter/material.dart';
import 'package:movie/domain/provider/movie_provder.dart';
import 'package:movie/ui/routes/app_navigator.dart';

import 'package:provider/provider.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppNavigator.initRoute,
        routes: AppNavigator.routes,
        onGenerateRoute: AppNavigator.generate,
      ),
    );
  }
}
