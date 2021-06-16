import 'package:flutter/material.dart';
import 'package:flutter_music_app/pages/root_app.dart';
import 'package:postgres/postgres.dart';

import 'Model/Data.dart';
Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Team 6 Music App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAlbum();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: RootApp(),
    );
  }
  fetchAlbum() async {
    var conn = PostgreSQLConnection(
        "192.168.1.167",
        5432, "musictify",
        username: "postgres",
        password: "Nr9.azYrWtFv6R/",
        timeoutInSeconds: 100);
    await conn.open();
    print("Connected to the database...");
    Data.albumData =
    await
    conn.query
       ("(select a.album_id,a.title as album_name, sum(stream_count) as total,count(distinct s.song_id) as song_number, a.release_date"+
        " from album a,song s,song_album sa where a.album_id = sa.album_id and s.song_id = sa.song_id"+
        " group by a.title,a.album_id order by total desc limit 5)"+
        " union all"+
        " (select a.album_id,a.title as album_name, sum(stream_count) as total,count(distinct s.song_id) as song_number, a.release_date"+
        " from album a,song s,song_album sa where a.album_id = sa.album_id and s.song_id = sa.song_id"+
        " group by a.title,a.album_id order by random() limit 5);");
    for(var row in Data.albumData){
      print(row);
    }
    await conn.close();
  }
}
