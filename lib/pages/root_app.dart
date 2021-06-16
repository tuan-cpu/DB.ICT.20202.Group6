import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_app/pages/search_page.dart';
import 'home_page.dart';
class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }
  Widget getBody(){
    return IndexedStack(
      index: activeTab,
      children: [
        HomePage(),
        Center(
          child: Text("Library",style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),
        ),
        SearchPage(),
        Center(
          child: Text("Settings",style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),
        ),
      ],
    );
  }
  Widget getFooter(){
    List items = [
      Icons.home,
      Icons.book,
      Icons.search,
      Icons.settings,
    ];
    return Container(
      height: 80,
      decoration: BoxDecoration(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index){
            return IconButton(
                onPressed: (){
                  setState(() {
                    activeTab = index;
                  });
                },
                icon: Icon(
                  items[index],
                  color: activeTab == index ? Colors.green : Colors.white,
                )
            );
          }),
        ),
      ),
    );
  }
}
