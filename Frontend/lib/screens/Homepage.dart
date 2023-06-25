import 'package:flutter_application_1/screens/Anim.dart';

import '../screens/regscreen.dart';
import 'package:flutter/material.dart';

import 'loginscreen.dart';



class Homepage extends StatefulWidget {

 const Homepage({Key? key}) : super(key: key);


 @override
 State<Homepage> createState() => _myhomepage();

}

class _myhomepage extends State<Homepage>{


@override
 Widget build(BuildContext context)
{
 return Scaffold(

   drawer: NavDrawer(),
   appBar: AppBar(
     title: Text('Menu'),
   ),


body: SingleChildScrollView(

  child: Column(
   mainAxisAlignment: MainAxisAlignment.spaceBetween,

   children:<Widget>[

     Container(

       height: 770,
   decoration: const BoxDecoration(
     image: DecorationImage(
       image: AssetImage('assets/assets/a2fgif.gif'),

       fit: BoxFit.cover,
       //fit: BoxFit.cover,

     )
   ),

     alignment: Alignment.center,
     padding: const EdgeInsets.all(10),
     child: Stack(
       children:<Widget> [



         Text(

           'Welcome to A2F',
           style: TextStyle(
             fontSize: 40,
             foreground: Paint()
               ..style = PaintingStyle.stroke
               ..strokeWidth = 6
               ..color = Colors.blue[700]!,
           ),

           textAlign: TextAlign.center,
         ),
         // Solid text as fill.
         Text(
           'Welcome to A2F',
           style: TextStyle(
             fontSize: 40,
             color: Colors.grey[300],

           ),
           textAlign: TextAlign.center,
         ),



       ],
     )
     ),




  ]
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
           onTap: () => {

             Navigator.push(context, MaterialPageRoute(builder:(context)=>anim()),)


           },
         ),
         ListTile(
           leading: Icon(Icons.app_registration),
           title: Text('SignUp'),
           onTap: () => {

           Navigator.push(context, MaterialPageRoute(builder:(context)=>Registration()),)

           },
         ),

         ListTile(
           leading: Icon(Icons.login),
           title: Text('LogIn'),
           onTap: () => {

             Navigator.push(context, MaterialPageRoute(builder:(context)=>LoginScreen()),)
           },
         ),

       ],
     ),
   );
 }
}



