import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/userInfo.dart';
import '../screens/Dashboard.dart';
import '../services/authServices.dart';

class withdraw extends StatefulWidget {
  final String token;
  const withdraw({Key? key, required this.token}) : super(key: key);

  @override
  State<withdraw> createState() => myWithdraw();
}

class myWithdraw extends State<withdraw> {
  var token, userInfo;
  var dio = Dio();
  var userID, amount, platformName, platformNumber;

  @override
  void initState() {
    super.initState();
    token = widget.token;
    userInfo = getUserInfo();
  }

  Future<UserInfo> getUserInfo() async {
    Response response = await AuthService().getInfo(token);
    var data = await jsonDecode(response.toString());
    return UserInfo.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A2F'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            padding: EdgeInsets.all(25),
            child: Column(children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        //padding: EdgeInsets.all(39),
                        padding: EdgeInsets.fromLTRB(35, 80, 10, 0),
                        child: Text(
                          'Withdraw From Wallet',
                          style: TextStyle(
                            fontFamily: "Font2",
                            fontSize: 25,
                            color: Colors.blueAccent[700],
                            fontWeight: FontWeight.bold,
                          ),
                          //textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        //padding: EdgeInsets.all(39),
                        padding: EdgeInsets.fromLTRB(10, 160, 10, 0),
                        child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Amount',
                              hintText: 'Amount',
                            ),
                            onChanged: (value) {
                              amount = value;
                            }),
                      ),
                      Padding(
                        //padding: EdgeInsets.all(39),
                        padding: EdgeInsets.fromLTRB(10, 240, 10, 0),
                        child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter the platform name',
                              hintText: 'Bkash/Nogod/Rocket/MasterCard',
                            ),
                            onChanged: (value) {
                              platformName = value;
                            }),
                      ),
                      Padding(
                        //padding: EdgeInsets.all(39),
                        padding: EdgeInsets.fromLTRB(10, 320, 10, 0),
                        child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter the platform credentials',
                              hintText: 'Bkash/Nogod/Rocket/MasterCard Number',
                            ),
                            onChanged: (value) {
                              platformNumber = value;
                            }),
                      ),
                      FractionallySizedBox(
                        widthFactor:
                            1.2, // Adjust the width factor as desired (0.8 means 80% of the available width)
                        child: FutureBuilder<UserInfo>(
                            future: userInfo,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              } else if (snapshot.hasData) {
                                var userID = snapshot.data!.user.id.toString();

                                return Container(
                                  margin: EdgeInsets.all(100),
                                  padding: EdgeInsets.fromLTRB(30, 340, 20, 0),
                                  child: FloatingActionButton.extended(
                                    label: Text('Withdraw'),
                                    backgroundColor: Colors.blueAccent,
                                    onPressed: () async {
                                      AuthService()
                                          .cashOut(userID, amount, platformName,
                                              platformNumber, context)
                                          .then((response) {
                                        if (response.data['success']) {
                                          String message =
                                              (response.data['message']);

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MenuDashboardPage(
                                                          token: token)));

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "$message",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0),
                                              ),
                                              duration: Duration(seconds: 2),
                                              backgroundColor: Colors.purple,
                                            ),
                                          );
                                        }
                                      });
                                    },
                                  ),
                                );
                              } else {
                                return const Text('No data');
                              }
                            }),
                      ),
                    ],
                  )),
            ])),
      ),
    );
  }
}
