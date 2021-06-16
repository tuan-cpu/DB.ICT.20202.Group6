import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_app/Model/Data.dart';
import 'package:page_transition/page_transition.dart';
import 'package:postgres/postgres.dart';

import 'music_detail_page.dart';

class AlbumPage extends StatefulWidget {
  final dynamic album;
  final dynamic songList;
  const AlbumPage({Key? key, this.album, this.songList}) : super(key: key);

  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: getBody(),
    );
  }
  Widget getBody(){
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: size.width,
                height: 220,
                decoration: BoxDecoration(
                  //image: DecorationImage(image: AssetImage(widget.song['img']),fit: BoxFit.cover),
                    color: Colors.green
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.album[1],
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white)),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 8),
                        child: Text('Subscribe',style: TextStyle(color: Colors.white),),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: List.generate(Data.albumData.length, (index){
                      return Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: GestureDetector(
                          onTap:(){
                            setState(() {
                              fetchSong(index);
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      alignment: Alignment.bottomCenter,
                                      child: AlbumPage(
                                        album: Data.albumData[index],
                                        songList: Data.songData,
                                      ),
                                      type: PageTransitionType.scale
                                  ));
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                  //TODO: load song image here
                                  //image: DecorationImage(image: AssetImage(),fit: BoxFit.cover),
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                              SizedBox(height: 20,),
                              Text(
                                //TODO:load song title here
                                Data.albumData[index][1],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600
                                ),),
                              SizedBox(height: 5,),
                              Container(
                                width: size.width-210,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      Data.albumData[index][3].toString()+" songs",
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    Text(
                                      Data.albumData[index][4].toString(),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ],
                                )
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Column(
                children: List.generate(widget.songList.length, (index)  {
                  return Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30,bottom: 10),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          Navigator.push(
                              context,
                              PageTransition(
                                  alignment: Alignment.bottomCenter,
                                  child: MusicDetailPage(
                                    title: widget.songList[index][1],
                                    description: 'This is sample descrition',
                                    songUrl: 'This is sample song url',
                                    img: 'This is sample image',
                                    color: Colors.green,
                                  ),
                                  type: PageTransitionType.scale
                              ));
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            width: (size.width-60)*0.77,
                            child: Text("${index+1}. "+widget.songList[index][1],
                              style: TextStyle(color: Colors.white),),
                          ),
                          Container(
                            width: (size.width-60)*0.23,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.songList[index][3].toString(),
                                  style: TextStyle(color: Colors.grey),),
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.withOpacity(0.8)
                                  ),
                                  child: Center(
                                    child: Icon(Icons.play_arrow,color: Colors.white,size: 16,),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios,color: Colors.white,)
                ),
                IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.more_vert,color: Colors.white,)
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  fetchSong(int index) async {
    var conn = PostgreSQLConnection(
        "192.168.1.167",
        5432, "musictify",
        username: "postgres",
        password: "Nr9.azYrWtFv6R/",
        timeoutInSeconds: 100);
    await conn.open();
    print("Connected to the database...");
    Data.songData = await conn.query(
        "select s.song_id,s.title as song_name,a.title as album_name,s.length from album a,song s,song_album sa"
            +" where a.album_id = sa.album_id and s.song_id = sa.song_id"
            +" and a.album_id = (select a.album_id from album a,song s,song_album sa"
            +" where a.album_id = sa.album_id and s.song_id = sa.song_id and s.song_id = @aValue);",
        substitutionValues: { "aValue":Data.albumData[index][0]}
    );
    for(var row in Data.songData){
      print(row);
    }
    await conn.close();
  }
}
