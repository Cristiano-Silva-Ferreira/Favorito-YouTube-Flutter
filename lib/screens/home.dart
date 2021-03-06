import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube/blocs/favorite_bloc.dart';
import 'package:favoritos_youtube/blocs/videos_bloc.dart';
import 'package:favoritos_youtube/delegates/data_search.dart';
import 'package:favoritos_youtube/models/video.dart';
import 'package:favoritos_youtube/widgets/video_tile.dart';
import 'package:flutter/material.dart';

import 'favorites_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<VideosBloc>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset('images/yt_logo_rgb_dark.png'),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('${snapshot.data.length}');
                } else {
                  return Container();
                }
              },
            ),
          ),
          IconButton(
              icon: Icon(Icons.star),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FavoritesScreen(),
                  ),
                );
              }),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String result = await showSearch(
                  context: context,
                  delegate: DataSearch(),
                );
                print('[Home.build().showSearch] result = $result');
                if (result != null && result.isNotEmpty) {
                  bloc.inSearch.add(result);
                }
              }),
        ],
      ),
      body: StreamBuilder(
        stream: BlocProvider.getBloc<VideosBloc>().outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length +
                    (snapshot.data.length > 0
                        ? 1
                        : 0), // + 1 to allow continuous scroll
                itemBuilder: (context, index) {
                  if (index < snapshot.data.length) {
                    return VideoTile(snapshot.data[index]);
                  } else {
                    bloc.inSearch.add(null);
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    );
                  }
                });
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
