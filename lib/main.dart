import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/blocs/videos_bloc.dart';
import 'package:favoritos_youtube/screens/api.dart';
import 'package:flutter/material.dart';

import 'screens/home.dart';

void main() {
  Api api = Api();
  api.search("eletro");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [Bloc((i) =>VideosBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Favoritos YouTube',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    );
  }
}
