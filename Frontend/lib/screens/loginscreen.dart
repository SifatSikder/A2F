import '../screens/regscreen.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:google_sign_in/google_sign_in.dart';

import '../services/authServices.dart';
import 'AdminDash.dart';
import 'Dashboard.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String _title1 = 'Welcome to A2F';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title1,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title1)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  var email, password, token;
  TextEditingController choiceController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoggedIn = false;
  late GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  // String check = '123';
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'A2F',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: choiceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                obscureText: passwordVisible,
                controller: passwordController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Password",
                  labelText: "Password",
                  // helperText: "Password must contain special character",
                  // helperStyle: TextStyle(color: Colors.green),
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(
                        () {
                          passwordVisible = !passwordVisible;
                        },
                      );
                    },
                  ),
                  alignLabelWithHint: false,
                  filled: true,
                ),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'Forgot Password',
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    email = choiceController.text;
                    password = passwordController.text;
                    print(email + password);
                    AuthService().login(email, password, context).then((value) {
                      print(value);
                      if (value.data['success']) {
                        // Fluttertoast.showToast(
                        //     msg: 'Login Successful',
                        //     toastLength: Toast.LENGTH_SHORT,
                        //     gravity: ToastGravity.BOTTOM,
                        //     timeInSecForIosWeb: 1,
                        //     backgroundColor: Colors.purple,
                        //     textColor: Colors.white,
                        //     fontSize: 16.0);

                        ScaffoldMessenger.of(context).showSnackBar
                        (
                          const SnackBar
                          (
                            content: Text('Login Successful',
                            style: TextStyle(color: Colors.white, fontSize: 16.0),),
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.deepPurple,
                          ),
                        );

                        token = value.data['token'];
                        if (token != null) {
                          print("code is here");
                          print(token);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MenuDashboardPage(token: token)));

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             AdminDash(token: token)));
                        }
                      }
                    });
                  },
                )),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registration()),
                    );
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Center(
              child: FloatingActionButton.extended(
                label: Text('Login with Google'), // <-- Text
                backgroundColor: Colors.black,
                icon: Image.asset(
                  'assets/assets/googleimage.png',
                  width: 28, // Adjust the width as desired
                  height: 28,
                ),
                onPressed: () {
                  _googleSignIn.signIn().then((userData) {
                    setState(() {
                      _isLoggedIn = true;
                      _userObj = userData!;
                    });
                  }).catchError((e) {
                    print(e);
                  });
                },
              ),

              //   // child: ElevatedButton(
              //   //   child: Text("Login with Google"),
              //   //   onPressed: () {
              //   //     _googleSignIn.signIn().then((userData) {
              //   //       setState(() {
              //   //         _isLoggedIn = true;
              //   //         _userObj = userData!;
              //   //       });
              //   //     }).catchError((e) {
              //   //       print(e);
              //   //     });
              //   //   },
              //   // ),
            ),
          ],
        ));
  }
}







// import 'package:a2f_frontend/services/authServices.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import 'Dashboard.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   //what we will need
//   var email, password, token;

//   @override
//   Widget build(BuildContext context) {
//     if (token != null)
//       Navigator.of(context).push(
//           MaterialPageRoute(builder: (context) => Dashboard(token: token)));
//     return Scaffold(
//       body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               decoration: InputDecoration(labelText: 'Email'),
//               onChanged: (value) {
//                 email = value;
//               },
//             ),
//             TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(labelText: 'Password'),
//                 onChanged: (value) {
//                   password = value;
//                 }),
//             SizedBox(height: 10.0),
//             ElevatedButton(
//                 child: const Text('Submit'),
//                 onPressed: () {
//                   AuthService().login(email, password).then((value) {
//                     if (value.data['success']) {
//                       Fluttertoast.showToast(
//                           msg: 'Login Successful',
//                           toastLength: Toast.LENGTH_SHORT,
//                           gravity: ToastGravity.BOTTOM,
//                           timeInSecForIosWeb: 1,
//                           backgroundColor: Colors.purple,
//                           textColor: Colors.white,
//                           fontSize: 16.0);
//                       token = value.data['token'];
//                       if (token != null) {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => Dashboard(token: token)));
//                       }
//                     }
//                   });
//                 },
//                 style: ElevatedButton.styleFrom(primary: Colors.blue)),
//           ]),
//     );
//   }
// }
