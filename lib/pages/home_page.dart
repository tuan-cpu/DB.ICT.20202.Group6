import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_music_app/Model/Data.dart';
import 'package:flutter_music_app/json/songs_json.dart';
import 'package:page_transition/page_transition.dart';
import 'package:postgres/postgres.dart';
import 'album_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeMenu1 = 0;
  int activeMenu2 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Explore",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              Icon(Icons.list)
            ],
          ),
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody(){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30,top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(song_type_1.length, (index){
                      return Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: GestureDetector(
                          onTap:(){
                            setState(() {
                              activeMenu1 = index;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                song_type_1[index],
                                style: TextStyle(
                                    color: activeMenu1 == index ? Colors.green:Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 3,),
                              activeMenu1 == index?Container(
                                width: 10,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                              ):Container()
                            ],
                          ),
                        ),
                      );
                    })
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: List.generate(Data.albumData.length-5, (index){
                      return Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: GestureDetector(
                          onTap:(){
                            setState(() async {
                              await fetchSong(index);
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
                                width: 180,
                                child: Text(
                                  //TODO: load song description here
                                  "Stream count: "+Data.albumData[index][2].toString(),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30,top: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(song_type_2.length, (index){
                        return Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: GestureDetector(
                            onTap:(){
                              setState(() {
                                activeMenu2 = index;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  song_type_2[index],
                                  style: TextStyle(
                                      color: activeMenu2 == index ? Colors.green:Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 3,),
                                activeMenu2 == index?Container(
                                  width: 10,
                                  height: 3,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                ):Container()
                              ],
                            ),
                          ),
                        );
                      })
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: List.generate(Data.albumData.length-5, (index){
                      return Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: GestureDetector(
                          onTap:(){
                            setState(() async {
                              await fetchSong(index);
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      alignment: Alignment.bottomCenter,
                                      child: AlbumPage(
                                          album: Data.albumData[index+5],
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
                                Data.albumData[index+5][1],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600
                                ),),
                              SizedBox(height: 5,),
                              Container(
                                width: 180,
                                child: Text(
                                  //TODO: load song description here
                                  "Stream count: "+Data.albumData[index+5][2].toString(),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
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
