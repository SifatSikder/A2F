import 'package:flutter/material.dart';



class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: about(),
    );
  }
}

class about extends StatefulWidget{
  @override
  _aboutState createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("About A2F"),
          backgroundColor: Colors.blueAccent.withOpacity(0.5),
          //0.5 is transparency
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Stack(
            children: [
              Container(


                decoration:
                  BoxDecoration(
                    image:
                      DecorationImage(
                        image: AssetImage("assets/assets/iit.jpg"),
                        fit: BoxFit.cover,
                      )
                  ),



                  //child: Image.asset("assets/assets/iit.jpg")

              ),

              Center(
                child: Container(
                  width: double.infinity,
                  color: Color.fromARGB(100, 22, 44, 33),
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(40),
                  child: Text("A2F is a community based lending application using crowdfunding concept. It is a mobile application where funds will be available anywhere and anytime.",
                    style: TextStyle(fontSize: 25, color: Colors.white),),
                ),
              ),
            ],
          ),
        )
    );
  }
}