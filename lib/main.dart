import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'blocs/favorite_bloc.dart';
import 'blocs/videos_bloc.dart';
import 'screens/home.dart';

void main() {
  //Api().search('eletro'); initial API test

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
        Bloc((i) => FavoriteBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        title: 'FlutterTube',
      ),
      dependencies: [],
    );
  }
}
