import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_app/pages/root_app.dart';
import 'package:rounded_button/rounded_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('images/musictify.png',width: 300,height: 300,),
          RoundedButton(
            text: 'Press To Continue',
            primaryColor: Colors.purple,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return RootApp();
              }));
            },
          )
        ],
      ),
    );
  }
}
