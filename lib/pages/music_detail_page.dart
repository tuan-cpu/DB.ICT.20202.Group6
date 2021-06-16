import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final Color color;
  final String img;
  final String songUrl;
  const MusicDetailPage({Key? key, required this.title, required this.description, required this.color, required this.img, required this.songUrl}) : super(key: key);

  @override
  _MusicDetailPageState createState() => _MusicDetailPageState();
}

class _MusicDetailPageState extends State<MusicDetailPage> {
  double _currentSliderValue = 0;
  //audio player here
  late AudioPlayer advancedPlayer;
  late AudioCache audioCache;
  bool isPlaying = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
  }
  initPlayer(){
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);
    playSound(widget.songUrl);
  }
  playSound(localPath)async{
    await audioCache.play(localPath);
  }
  stopSound(localPath)async{
    File audioFile = (await audioCache.load(localPath)) as File;
    await advancedPlayer.setUrl(audioFile.path);
    advancedPlayer.stop();
  }
  seekSound()async{
    File audioFile = (await audioCache.load(widget.songUrl)) as File;
    await advancedPlayer.setUrl(audioFile.path);
    advancedPlayer.seek(Duration(milliseconds: 2000));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stopSound(widget.songUrl);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.more_vert)
          )
        ],
      ),
      body: getBody(),
    );
  }
  Widget getBody(){
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30,top: 20),
                child: Container(
                  width: size.width-100,
                  height: size.width-100,
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: widget.color,blurRadius: 50,spreadRadius: 5,offset: Offset(-10,40))],
                      borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30,top: 20),
                child: Container(
                  width: size.width-60,
                  height: size.width-60,
                  decoration: BoxDecoration(
                      color: Colors.green,
                    //image: DecorationImage(image: AssetImage(widget.img),fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Container(
              width: size.width-80,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.create_new_folder,color: Colors.white,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(widget.title,style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
                      Container(
                        width: 150,
                        child: Text(
                          widget.description,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white.withOpacity(0.5),
                          ),),
                      ),
                    ],
                  ),
                  Icon(Icons.more_vert,color: Colors.white,)
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Slider(
              activeColor: Colors.green,
              value: _currentSliderValue,
              min: 0,
              max: 200,
              onChanged: (value){
                setState(() {
                  _currentSliderValue = value;
                });
                seekSound();
              }),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("0:00",style: TextStyle(color: Colors.white.withOpacity(0.5)),),
                Text("5:00",style: TextStyle(color: Colors.white.withOpacity(0.5)),),
              ],
            ),
          ),
          SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: (){}, 
                    icon: Icon(Icons.shuffle,color: Colors.white.withOpacity(0.8),size: 25,)
                ),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.skip_previous,color: Colors.white.withOpacity(0.8),size: 25,)
                ),
                IconButton(
                    iconSize: 50,
                    onPressed: (){
                      if(isPlaying){
                        stopSound(widget.songUrl);
                        setState(() {
                          isPlaying = false;
                        });
                      }else{
                        playSound(widget.songUrl);
                        setState(() {
                          isPlaying = true;
                        });
                      }
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green),
                      child: Center(
                        child: Icon(
                          isPlaying?Icons.stop:Icons.play_arrow,
                          size: 28,color: Colors.white,),
                      ),
                    )
                ),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.skip_next,color: Colors.white.withOpacity(0.8),size: 25,)
                ),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.fast_rewind,color: Colors.white.withOpacity(0.8),size: 25,)
                ),
              ],
            ),
          ),
          SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.tv,color: Colors.green,size: 20,),
              SizedBox(width: 10,),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text("Chromecast is ready",style: TextStyle(
                  color: Colors.green,
                ),),
              )
            ],
          )
        ],
      ),
    );
  }
}
