import '../services/authServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


import 'loginscreen.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

// {
//   "email":"bsse1223@iit.du.ac.bd",
//   "password":"1234",
//   "username":"sifat",
//   "UniversityRegistrationID":"2019316864",
//   "PhoneNumber":"01987959788",
//   "bKashNumber":"01987959788",
//   "currentBsseYear":"3rd"
// }
class _RegistrationState extends State<Registration> {
  //what we will need
  var email,
      password,
      username,
      UniversityRegistrationID,
      PhoneNumber,
      bKashNumber,
      currentBsseYear;

  bool passwordVisible1 = false;
  bool _validate = false;
  bool _validate1 = false;
  bool _validate2 = false;
  bool _validate3 = false;
  bool _validate4 = false;
  bool _validate5 = false;
  bool _validate6 = false;
  bool _validate7 = false;

  @override
  void initState() {
    super.initState();
    passwordVisible1 = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A2F'),
      ),
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  errorText: _validate1 ? 'Value Can\'t Be Empty' : null,
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                  obscureText: passwordVisible1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible1
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(
                          () {
                            passwordVisible1 = !passwordVisible1;
                          },
                        );
                      },
                    ),
                    alignLabelWithHint: false,
                    filled: true,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    password = value;
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                    errorText: _validate ? 'Value Can\'t Be Empty' : null,
                  ),
                  onChanged: (value) {
                    username = value;
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'University Registration ID',
                    errorText: _validate2 ? 'Value Can\'t Be Empty' : null,
                  ),
                  onChanged: (value) {
                    UniversityRegistrationID = value;
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                    errorText: _validate5 ? 'Value Can\'t Be Empty' : null,
                  ),
                  onChanged: (value) {
                    PhoneNumber = value;
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'bKash Number',
                    errorText: _validate6 ? 'Value Can\'t Be Empty' : null,
                  ),
                  onChanged: (value) {
                    bKashNumber = value;
                  }),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Current BSSE Year',
                    errorText: _validate7 ? 'Value Can\'t Be Empty' : null,
                  ),
                  onChanged: (value) {
                    currentBsseYear = value;
                  }),
            ),
            // SizedBox(height: 30.0),
            Container(
                height: 70,
                width: 1000,
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ElevatedButton(
                  child: const Text('Sign Up'),
                  onPressed: () {
                    print('code is here');
                    bool emailValid = RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                        .hasMatch(email);
                    print(emailValid);

                    if (emailValid == false) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('Invalid Email Format !'),
                        duration: const Duration(seconds: 2),
                      ));
                    } else {
                      AuthService()
                          .register(
                              email,
                              password,
                              username,
                              UniversityRegistrationID,
                              PhoneNumber,
                              bKashNumber,
                              currentBsseYear,
                             context)
                          .then((value) {
                        if (value.data['success']) {
                          // Fluttertoast.showToast(
                          //     msg: 'Registration Successful',
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.BOTTOM,
                          //     timeInSecForIosWeb: 1,
                          //     backgroundColor: Colors.purple,
                          //     textColor: Colors.white,
                          //     fontSize: 16.0);


                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Registration Successful',
                                style: TextStyle(color: Colors.white, fontSize: 16.0),
                              ),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.deepPurple,
                            ),
                          );


                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        } else {
                          // Fluttertoast.showToast(
                          //     msg: value.data['message'],
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.BOTTOM,
                          //     timeInSecForIosWeb: 1,
                          //     backgroundColor: Colors.purple,
                          //     textColor: Colors.white,
                          //     fontSize: 16.0);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                value.data['message'],
                                style: TextStyle(color: Colors.white, fontSize: 16.0),
                              ),
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.deepPurple,
                            ),
                          );


                        }
                      });
                    }

                    setState(() {
                      username.isEmpty ? _validate = true : _validate = false;
                      email.isEmpty ? _validate1 = true : _validate1 = false;
                      UniversityRegistrationID.isEmpty
                          ? _validate2 = true
                          : _validate2 = false;
                      password.isEmpty ? _validate3 = true : _validate3 = false;
                      PhoneNumber.isEmpty
                          ? _validate5 = true
                          : _validate = false;
                      bKashNumber.isEmpty
                          ? _validate6 = true
                          : _validate = false;
                      currentBsseYear.isEmpty
                          ? _validate7 = true
                          : _validate = false;
                    });
                  },
                )),
            // Container(
            //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            //   child: ElevatedButton(
            //       child: const Text('Login'),
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => const LoginScreen()));
            //       },
            //       style: ElevatedButton.styleFrom(primary: Colors.blue)),
            // ),
          ])),
    );
  }
}
