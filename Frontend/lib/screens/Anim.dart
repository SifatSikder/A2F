import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_application_1/screens/regscreen.dart';

import 'About.dart';
import 'loginscreen.dart';

class anim extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amader A2F',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LendingPage(),
    );
  }
}

class LendingPage extends StatefulWidget {
  @override
  _LendingPageState createState() => _LendingPageState();
}

class _LendingPageState extends State<LendingPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;



  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 40.0,
    fontFamily: 'Horizon',
    //textAlign: TextAlign.center,
  );


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    _fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Menu'),
      ),

      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fadeInAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [








                  Image.asset(
                    'assets/assets/logo2.png',
                    width: 150,
                    height: 150,
                  ),


                  //
                  // FlutterLogo(
                  //   size: 150,
                  // ),



                  //aaaaaa
              SizedBox(
                width: 350.0,


                child: AnimatedTextKit(

                  animatedTexts: [
                    ColorizeAnimatedText(

                      "Let's Create ",
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                    ColorizeAnimatedText(
                      'A Better Tomorrow',
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                    // ColorizeAnimatedText(
                    //   'Steve Jobs',
                    //   textStyle: colorizeTextStyle,
                    //   colors: colorizeColors,
                    // ),
                  ],
                  isRepeatingAnimation: true,
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ),



                // SizedBox(
                //   width: 250.0,
                //   child: DefaultTextStyle(
                //     style: const TextStyle(
                //       fontSize: 32.0,
                //       fontWeight: FontWeight.bold,
                //       color:Colors.blueAccent
                //     ),
                //     child: AnimatedTextKit(
                //       animatedTexts: [
                //         FadeAnimatedText('do IT!'),
                //         FadeAnimatedText('do it RIGHT!!'),
                //         FadeAnimatedText('do it RIGHT NOW!!!'),
                //       ],
                //       onTap: () {
                //         print("Tap Event");
                //       },
                //     ),
                //   ),
                // ),




                  //
                  // SizedBox(height: 20),
                  // Text(
                  //   'A2F',
                  //   style: TextStyle(
                  //     fontSize: 24,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // SizedBox(height: 10),
                  // Text(
                  //   'Welcome to A2F!',
                  //   style: TextStyle(fontSize: 18),
                  // ),
                  // SizedBox(height: 10),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 50),
                  //   child: Text(
                  //     "A2F is a community based lending application where funds will be available anywhere and anytime.The mission of A2F is to provide short term loans within a specified community and also raise funds for that community welfare.",
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(fontSize: 19),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: const AssetImage('assets/assets/money2.webp'))),

          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About Us'),
            onTap: () =>
            {

              Navigator.push(
                context, MaterialPageRoute(builder: (context) => about()),)
            },
          ),
          ListTile(
            leading: Icon(Icons.app_registration),
            title: Text('SignUp'),
            onTap: () =>
            {

              Navigator.push(context,
                MaterialPageRoute(builder: (context) => Registration()),)
            },
          ),

          ListTile(
            leading: Icon(Icons.login),
            title: Text('LogIn'),
            onTap: () =>
            {

              Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()),)
            },
          ),

        ],
      ),
    );
  }
}
