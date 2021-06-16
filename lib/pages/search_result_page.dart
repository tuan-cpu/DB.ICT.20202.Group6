import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'music_detail_page.dart';

class ResultPage extends StatefulWidget {
  final dynamic result;
  const ResultPage({Key? key, this.result}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
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
              Text('Search Result:',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold, color: Colors.white),),
              Column(
                children: List.generate(widget.result.length, (index)  {
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
                                    title: widget.result[index][0],
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
                            child: Text("${index+1}. "+widget.result[index][0],
                              style: TextStyle(color: Colors.white),),
                          ),
                          Container(
                            width: (size.width-60)*0.23,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.result[index][1].toString(),
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
}
