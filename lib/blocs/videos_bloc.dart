import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/models/video.dart';
import 'package:favoritos_youtube/screens/api.dart';

class VideosBloc implements BlocBase {
  // Importando a Api
  Api api;

  // Criando uma lista de videos
  List<Video> videos;

  // Implementando o Stream
  final StreamController _videoController = StreamController();

  // Definindo a saida dos videos
  Stream get outVideo => _videoController.stream;

  // Definindo a entrada
  final StreamController _searchController = StreamController();
  Sink get inSearch => _searchController.sink;

  // Criando o construdor
  VideosBloc() {
    api = Api();

    // Recebendo os dados do inSearch
    _searchController.stream.listen(_search);
  }

  // Função de pesquisar os dados do video
  void _search(String search) async {
    videos = await api.search(search);

    print(videos);
  }

  @override
  void dispose() {
    // Fechando o stream
    _videoController.close();
    _searchController.close();
  }
}
