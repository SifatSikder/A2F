import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/models/userInfo.dart';

import '../services/authServices.dart';
import '../services/loanservices.dart';
import 'Dashboard.dart';

class RepayLoan extends StatefulWidget {
  final String token;
  final String userID;
  const RepayLoan({super.key, required this.token, required this.userID});

  @override
  State<RepayLoan> createState() => _RepayLoanState();
}

class _RepayLoanState extends State<RepayLoan> {
  var token;
  var userID;
  var repayAmount;
  Dio dio = Dio();
  late Future<UserInfo> userInfo;

  Future<UserInfo> getUserInfo() async {
    Response response = await AuthService().getInfo(token);
    print('Response is ' + response.toString());
    var data = await jsonDecode(response.toString());
    return UserInfo.fromJson(data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    token = widget.token;
    userID = widget.userID;
    userInfo = getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A2F'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(children: <Widget>[
              Row(children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Card(
                            elevation: 3,
                            child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(children: <Widget>[
                                  FutureBuilder<UserInfo>(
                                      future: userInfo,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return Text('${snapshot.error}');
                                        } else if (snapshot.hasData) {
                                          print(snapshot.data!);
                                          return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount:
                                                snapshot.data!.loan.length,
                                            itemBuilder: (context, index) {
                                              final amountToBePaid = snapshot
                                                  .data!
                                                  .repaymentDetails[0]
                                                  .amountToBePaid;
                                              final paidTillNow = snapshot
                                                  .data!
                                                  .repaymentDetails[0]
                                                  .paidTillNow;
                                              final remainingInstallments =
                                                  snapshot
                                                      .data!
                                                      .repaymentDetails[0]
                                                      .remainingInstallments;
                                              final repaymentDaysRemaining =
                                                  snapshot
                                                      .data!
                                                      .repaymentDetails[0]
                                                      .repaymentDaysRemaining;

                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        'Repayment details'),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        'Total Repayment Amount: $amountToBePaid'),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        'Already Paid Amount: $paidTillNow'),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        'Deadline Remaining : ${repaymentDaysRemaining} days'),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        'Installments Remaining : ${remainingInstallments}'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text('${snapshot.error}');
                                        }
                                        return const CircularProgressIndicator();
                                      }),
                                ])))))
              ]),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Padding(
                          //padding: EdgeInsets.all(39),
                          padding: EdgeInsets.fromLTRB(20, 60, 10, 0),
                          child: Text(
                            'Amount you want to repay',
                            style: TextStyle(
                              fontFamily: "Font2",
                              fontSize: 27,
                              color: Colors.blueAccent[700],
                              fontWeight: FontWeight.bold,
                            ),
                            //textAlign: TextAlign.center,
                          ),
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
                              repayAmount = value;
                            }),
                      ),
                      FractionallySizedBox(
                        widthFactor:
                            1.2, // Adjust the width factor as desired (0.8 means 80% of the available width)
                        child: Container(
                          margin: EdgeInsets.all(100),
                          padding: EdgeInsets.fromLTRB(30, 180, 20, 0),
                          child: FloatingActionButton.extended(
                            label: Text('Submit'),
                            backgroundColor: Colors.blueAccent,
                            onPressed: () async {
                              var response = await LoanService()
                                  .repayLoan(repayAmount, userID, context);
                              print('sda');
                              print(response);

                              if (response.data['success']) {
                                // Fluttertoast.showToast(
                                //     msg: response.data['message'],
                                //     toastLength: Toast.LENGTH_SHORT,
                                //     gravity: ToastGravity.BOTTOM,
                                //     timeInSecForIosWeb: 1,
                                //     backgroundColor: Colors.purple,
                                //     textColor: Colors.white,
                                //     fontSize: 16.0)

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      response.data['message'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    ),
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.purple,
                                  ),
                                );
                              }
                              ;

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      MenuDashboardPage(token: token)));
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
            ])),
      ),
    );
  }
}
