import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_app/Model/Data.dart';
import 'package:flutter_music_app/pages/search_result_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:postgres/postgres.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: getBody(),
    );
  }
  Widget getBody(){
    return Container(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                    "Search",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: _searchController,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search,color: Colors.black,size: 28.0,),
                  filled: true,
                  border: OutlineInputBorder(),
                  hintText: "Find your music",
                  hintStyle: TextStyle(color: Colors.grey,fontSize: 20)
                ),
                  onSubmitted: (input) => _searchController.text = input,
              ),
            ),
            IconButton(
                iconSize: 50,
                onPressed: () async {
                  await fetchSK();
                  _searchController.text = '';
                  Navigator.push(
                      context,
                      PageTransition(
                          alignment: Alignment.bottomCenter,
                          child: ResultPage(
                            result: Data.keywordData,
                          ),
                          type: PageTransitionType.scale
                      ));
                },
                icon: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green),
                  child: Center(
                    child: Icon(
                      Icons.search,
                      size: 28,color: Colors.white,),
                  ),
                )
            )
          ],
        ),
    );
  }
  fetchSK() async {
    var conn = PostgreSQLConnection(
        "192.168.1.167",
        5432, "musictify",
        username: "postgres",
        password: "Nr9.azYrWtFv6R/",
        timeoutInSeconds: 100);
    await conn.open();
    print("Connected to the database...");
    Data.keywordData = await conn.query(
        "select s.title,s.length from song_keyword sk,song s,keyword k"
        +" where sk.song_id = s.song_id and sk.keyword_id = k.keyword_id"
        +" and k.keyword = @aValue;",
        substitutionValues: { "aValue":_searchController.text}
    );
    for(var row in Data.keywordData){
      print(row);
    }
    await conn.close();
  }
}
