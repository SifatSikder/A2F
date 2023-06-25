import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/repayLoan.dart';

import '../Forms/CFM_Admin.dart';
import '../Forms/RechargeFoRM.dart';
import '../Forms/LoanForm.dart';
import '../Forms/withdrawForm.dart';
import '../Forms/donateForm.dart';
import '../Forms/LoanFeed.dart';
import '../Forms/fundraising.dart';
import 'package:dio/dio.dart';

import '../Statistics/lineChart.dart';
import '../models/userInfo.dart';
import 'ApplyLoan.dart';
import 'Homepage.dart';

final Color backgroundColor = Color(0xFF2d2d39);

class TransactionDetails {
  final double loan_amount;
  final double time;

  TransactionDetails({
    required this.loan_amount,
    required this.time,
  });
}

class AdminDash extends StatefulWidget {
  @override
  final String token;
  const AdminDash({
    super.key,
    required this.token,
  });

  _AdminDashState createState() => _AdminDashState();
}

class _AdminDashState extends State<AdminDash>
    with SingleTickerProviderStateMixin {
  String text = "";
   String base_address='http://192.168.1.106:8000';
  //String base_address = 'http://10.0.2.2:8000';
  //String base_address = 'http://localhost:8000';
  var token;
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 200);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;



  var userID;

  double mainBorderRadius = 0;

  Brightness statusIconColor = Brightness.dark;

  Dio dio = new Dio();
  late Future<UserInfo> userInfo;

  var amount, loan_num;
  Future<UserInfo> getUserInfo() async {
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response = await dio.get('${base_address}/user/dashboard');
    print('Response is ' + response.toString());
    var data = await jsonDecode(response.toString());
    return UserInfo.fromJson(data);
  }

  //bujhinai
  List<TransactionDetails> todayTransactionsList = [
    new TransactionDetails(
      loan_amount: 200,
      time: 20,
    ),
  ];

  @override
  void initState() {
    super.initState();
    token = widget.token;
    userInfo = getUserInfo();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.7).animate(_controller);
    _menuScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1,
    ).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //bujhinai
  Widget menuItem({
    required IconData iconData,
    required String title,
    bool active: false,
  }) {
    return SizedBox(
      width: 0.5 * screenWidth,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 20,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Icon(
                iconData,
                color: (active) ? Colors.white : Colors.grey,
                size: 22,
              ),
            ),
            Expanded(
              flex: 14,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  "$title",
                  style: TextStyle(
                    color: (active) ? Colors.white : Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 40),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        width: 0.3 * screenWidth,
                        margin: EdgeInsets.only(
                          top: 50,
                          bottom: 10,
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            // SizedBox(
                            //   height: 0.3 * screenWidth,
                            //   width: 0.3 * screenWidth,
                            //   child: Container(
                            //     alignment: Alignment.topLeft,
                            //     decoration: BoxDecoration(
                            //       shape: BoxShape.circle,
                            //       image: DecorationImage(
                            //           image: AssetImage('assets/profile1.jpg')),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 0.3 * screenWidth,
                              width: 0.3 * screenWidth,
                              child: Container(
                                alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/assets/profile1.jpg')),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ListView(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            Text(
                              'Tasnia Hoque',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Dhaka, Bangladesh',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      menuItem(
                        title: "DASHBOARD",
                        iconData: Icons.account_balance,
                        active: true,
                      ),
                      menuItem(
                        title: "USER PROFILE",
                        iconData: Icons.account_circle_outlined,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                menuItem(
                  title: "Logout",
                  iconData: Icons.exit_to_app,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomBar() {
    return Align(
      alignment: Alignment(-1, 1),
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
        height: 70,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: IconButton(
                  highlightColor: Colors.red,
                  splashColor: Colors.greenAccent,
                  icon: Icon(
                    Icons.home,
                    color: Color(0xffa1a5b5),
                  ),
                  iconSize: 28,
                  onPressed: () {},
                )),
            Expanded(
              flex: 1,
              child: IconButton(
                iconSize: 28,
                icon: Icon(
                  Icons.swap_horiz,
                  color: Color(0xffa1a5b5),
                  size: 28,
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(
                  Icons.show_chart,
                  color: Color(0xffa1a5b5),
                ),
                iconSize: 28,
                onPressed: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                iconSize: 28,
                icon: Icon(
                  Icons.notifications_none,
                  color: Color(0xffa1a5b5),
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                iconSize: 28,
                icon: Icon(
                  Icons.person_outline,
                  color: Color(0xffa1a5b5),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Wallet({
    required int amount,
    required String cardNumber,
    required String cardHolder,
    required String expiringDate,
    required String bankEnding, //sssssssssssssssssssssssssss
    required Color backgroundColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width - 30,
      child: Stack(
        children: <Widget>[
          ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            children: <Widget>[
              Text(
                'My Wallet',
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Text(
                '$amount BDT',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              FutureBuilder<UserInfo>(
                  future: userInfo,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else if (snapshot.hasData) {
                      userID = snapshot.data!.user.id.toString();

                      print(userID);
                      return ListTile(
                        title: Text('Recharge Wallet'),
                        onTap: () => {
                          catch_amount(context, userID)
                          //Navigator.of(context).pop()
                          //Navigator.push(context, MaterialPageRoute(builder:(context)=>Recharge()),)
                        },
                      );
                    } else {
                      return const Text('No data');
                    }
                  }),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          Positioned(
            right: 25,
            top: 25,
            child: SizedBox(
              // width: 90,
              child: Row(
                children: <Widget>[
                  Text(
                    'Bank',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$bankEnding',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 25,
            bottom: 25,
            child: Container(
              child: Icon(
                Icons.credit_card,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  int a = 0;
  int total = 0;
  void catch_amount(BuildContext context, userID) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Recharge(userID, token),
        ));
  }


  Widget Loan_Num({
    required int loan_num,
    required Color backgroundColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width - 30,
      child: Stack(
        children: <Widget>[
          ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            children: <Widget>[
              Text(
                'No. Of Loans Taken',
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Text(
                '\n $loan_num',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          Positioned(
            right: 25,
            top: 25,
            child: SizedBox(
              // width: 90,
              child: Row(
                children: <Widget>[
                  Text(
                    'Bank',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 25,
            bottom: 25,
            child: Container(
              child: Icon(
                Icons.credit_card,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget Loan_Given_Num({
    required int loan_given,
    required Color backgroundColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width - 30,
      child: Stack(
        children: <Widget>[
          ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            children: <Widget>[
              Text(
                'No. Of Loans Given',
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Text(
                '\n $loan_given',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          Positioned(
            right: 25,
            top: 25,
            child: SizedBox(
              // width: 90,
              child: Row(
                children: <Widget>[
                  Text(
                    'Bank',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 25,
            bottom: 25,
            child: Container(
              child: Icon(
                Icons.credit_card,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget Withdraw({
    required double withdraw_amount,
    required Color backgroundColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width - 30,
      child: Stack(
        children: <Widget>[
          ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            children: <Widget>[
              Text(
                'Withdraw From Wallet',
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Text(
                '\n $withdraw_amount',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              ListTile(
                title: Text('Request a withdrawal amount'),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              withdraw(token:token)))
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          Positioned(
            right: 25,
            top: 25,
            child: SizedBox(
              // width: 90,
              child: Row(
                children: <Widget>[
                  Text(
                    'Bank',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 25,
            bottom: 25,
            child: Container(
              child: Icon(
                Icons.credit_card,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget transactionList(
      List<TransactionDetails> transactionList,
      String strDate, {
        bool lastElement: false,
      }) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        ListView.builder(
          padding: EdgeInsets.fromLTRB(5, 15, 5, (lastElement) ? 40 : 5),
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            TransactionDetails _transaction = transactionList[index];
            return Container(
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3,
                  )
                ],
              ),
              // padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                title: Text(
                  "Apply for a New Loan!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                subtitle: Column(
                  children: <Widget>[
                    Container(
                        child: Column(
                          children: <Widget>[
                            FutureBuilder<UserInfo>(
                                future: userInfo,
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    userID = snapshot.data!.user.id.toString();
                                    return Container(
                                      child: Text(''),
                                    );
                                  } else {
                                    return const Text('');
                                  }
                                }),
                            TextButton(
                              child: Text("APPLY HERE !"),
                              onPressed: () {
                                print(token);
                                print(userID);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ApplyLoan(
                                        token: token,
                                        userID: userID,
                                      )),
                                );
                              },
                              style: TextButton.styleFrom(
                                fixedSize: Size.fromWidth(335),
                                primary: Colors.white,
                                backgroundColor: Colors.green, // Background Color
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            );
          },
          itemCount: transactionList.length,
        ),
      ],
    );
  }

  Widget transactionList2(
      List<TransactionDetails> transactionList,
      String strDate, {
        bool lastElement: false,
      }) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        ListView.builder(
          padding: EdgeInsets.fromLTRB(5, 15, 5, (lastElement) ? 40 : 5),
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            TransactionDetails _transaction = transactionList[index];
            return Container(
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3,
                  )
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                title: Text(
                  "Loan Feeds",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                subtitle: Column(
                  children: <Widget>[
                    // Container(height: 50, color: Colors.red, child: Row()),
                    Container(
                        child: Column(
                          children: <Widget>[
                            FutureBuilder<UserInfo>(
                                future: userInfo,
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    userID = snapshot.data!.user.id.toString();

                                    return Container(
                                      child: Text(''),
                                    );
                                  } else {
                                    return const Text('No data');
                                  }
                                }),
                            TextButton(
                              child: Text("REVIEW AND LEND LOANS !"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllLoans(
                                        token: token,
                                        userID: userID,
                                      )),
                                );
                              },
                              style: TextButton.styleFrom(
                                fixedSize: Size.fromWidth(335),
                                primary: Colors.white,
                                backgroundColor:
                                Colors.blueAccent, // Background Color
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            );
          },
          itemCount: transactionList.length,
        ),
      ],
    );
  }

  Widget transactionList3_Fundraising(
      List<TransactionDetails> transactionList,
      String strDate, {
        bool lastElement: false,
      }) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        ListView.builder(
          padding: EdgeInsets.fromLTRB(5, 15, 5, (lastElement) ? 40 : 5),
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            TransactionDetails _transaction = transactionList[index];
            return Container(
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3,
                  )
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                title: Text(
                  "Apply for Fundraising",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                subtitle: Column(
                  children: <Widget>[
                    // Container(height: 50, color: Colors.red, child: Row()),
                    Container(
                        child: Column(
                          children: <Widget>[
                            TextButton(
                              child: Text("APPLY HERE !"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => fundForm()),
                                );
                              },
                              style: TextButton.styleFrom(
                                fixedSize: Size.fromWidth(335),
                                primary: Colors.white,
                                backgroundColor: Colors.green, // Background Color
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            );
          },
          itemCount: transactionList.length,
        ),
      ],
    );
  }

  Widget transactionList4_donate(
      List<TransactionDetails> transactionList,
      String strDate, {
        bool lastElement: false,
      }) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        ListView.builder(
          padding: EdgeInsets.fromLTRB(5, 15, 5, (lastElement) ? 40 : 5),
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            TransactionDetails _transaction = transactionList[index];
            return Container(
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3,
                  )
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                title: Text(
                  "Donate in Fundraising",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                subtitle: Column(
                  children: <Widget>[
                    Container(
                        child: Column(
                          children: <Widget>[
                            TextButton(
                              child: Text("DONATE "),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DonateForm()),
                                );
                              },
                              style: TextButton.styleFrom(
                                fixedSize: Size.fromWidth(335),
                                primary: Colors.white,
                                backgroundColor:
                                Colors.blueAccent, // Background Color
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            );
          },
          itemCount: transactionList.length,
        ),
      ],
    );
  }

  Widget repayLoan(
      List<TransactionDetails> transactionList,
      String strDate, {
        bool lastElement: false,
      }) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        ListView.builder(
          padding: EdgeInsets.fromLTRB(5, 15, 5, (lastElement) ? 40 : 5),
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            TransactionDetails _transaction = transactionList[index];
            return Container(
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3,
                  )
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                title: Text(
                  "Repay Loan",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                subtitle: Column(
                  children: <Widget>[
                    Container(
                        child: Column(
                          children: <Widget>[
                            FutureBuilder<UserInfo>(
                                future: userInfo,
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    userID = snapshot.data!.user.id.toString();

                                    return TextButton(
                                      child: Text("Repay"),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => RepayLoan(
                                                token: token,
                                                userID: userID,
                                              )),
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        fixedSize: Size.fromWidth(335),
                                        primary: Colors.white,
                                        backgroundColor:
                                        Colors.green, // Background Color
                                      ),
                                    );
                                  } else {
                                    return const Text('No data');
                                  }
                                }),
                          ],
                        ))
                  ],
                ),
              ),
            );
          },
          itemCount: transactionList.length,
        ),
      ],
    );
  }

  Widget dashboard(context) {
    print(loan_num);
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.5 * screenWidth,
      width: screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius: BorderRadius.circular(mainBorderRadius),
          animationDuration: duration,
          color: Color(0xfff4faff),
          child: SafeArea(
              child: Stack(
                children: <Widget>[
                  ListView(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                          top: 5,
                          bottom: 50,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "My Dashboard",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_circle_outline,
                                      color: Color(0xff1c7bfd),
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: (MediaQuery.of(context).size.width - 30) *
                                  (8 / 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              child: FutureBuilder<UserInfo>(
                                  future: userInfo,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    } else if (snapshot.hasData) {
                                      amount = snapshot.data!.user.wallet +
                                          snapshot.data!.user.loanwallet -
                                          snapshot.data!.user.cashOutTillNow;
                                      loan_num = snapshot.data!.loan.length;

                                      print(snapshot.data!.user.wallet);
                                      return PageView(
                                        controller:
                                        PageController(viewportFraction: 0.9),
                                        scrollDirection: Axis.horizontal,
                                        pageSnapping: true,
                                        children: <Widget>[
                                          Wallet(
                                            amount: amount,
                                            cardHolder: snapshot.data!.user.username
                                                .toUpperCase(),
                                            cardNumber: '4545',
                                            expiringDate: '02/21',
                                            bankEnding: 'X',
                                            backgroundColor:
                                            Colors.deepOrangeAccent,
                                          ),
                                          Loan_Num(
                                            loan_num: loan_num,
                                            backgroundColor: Colors.blueAccent,
                                          ),
                                          Loan_Given_Num(
                                            loan_given: 0,
                                            backgroundColor: Colors.redAccent,
                                          ),
                                          Withdraw(
                                            withdraw_amount: snapshot
                                                .data!.user.withdrawAmount
                                                .toDouble(),
                                            backgroundColor: Colors.greenAccent,
                                          ),
                                        ],
                                      );
                                    } else {
                                      return const Text('No data');
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ListView(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            SizedBox(height: 15),
                            Container(
                              padding: EdgeInsets.only(
                                bottom: 16,
                                left: 16,
                                right: 16,
                              ),
                              child: ListView(
                                physics: ClampingScrollPhysics(),
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                shrinkWrap: true,
                                children: <Widget>[
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Transactions",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.settings,
                                          color: Color(0xffa4a6b8),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                  transactionList(todayTransactionsList,
                                      'Apply for a new Loan'),
                                  transactionList2(
                                      todayTransactionsList, 'Loan Feeds'),
                                  transactionList3_Fundraising(
                                      todayTransactionsList, ''),
                                  transactionList4_donate(
                                      todayTransactionsList, ''),
                                  repayLoan(todayTransactionsList, ''),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  bottomBar(),
                ],
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: statusIconColor,
      ),
    );

    return Scaffold(
      // drawer: NavDrawer2(screenHeight, screenWidth, userID, token),
      drawer: NavDrawer2(screenHeight, screenWidth, token),
      appBar: AppBar(
        title: Text('A2F'),
      ),
      backgroundColor: Color(0xff343442),
      body: Stack(
        children: <Widget>[
          dashboard(context),
        ],
      ),
    );
  }
}

class NavDrawer2 extends StatelessWidget {
  double screenHeight;
  double screenWidth;
  String token;
  // String base_address='http://10.100.101.51:8000';
  String base_address = 'http://10.0.2.2:8000';
  //String base_address = 'http://localhost:8000';

  NavDrawer2(
      double this.screenHeight, double this.screenWidth, String this.token,
      {super.key});

  Dio dio = new Dio();

  Future<UserInfo> getUserInfo() async {
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response = await dio.get('${base_address}/user/dashboard');
    print('Response is ' + response.toString());
    var data = await jsonDecode(response.toString());
    return UserInfo.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    Future<UserInfo> userInfo = getUserInfo();
    print(userInfo);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('assets/assets/profile1.jpg'),
                backgroundColor: Colors.greenAccent,
                radius: 50,
              ),

              SingleChildScrollView(
                child: FutureBuilder<UserInfo>(
                    future: userInfo,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return Text('${snapshot.error}');
                      } else if (snapshot.hasData) {
                        var userID = snapshot.data!.user.id.toString();
                        var userName=snapshot.data!.user.username.toUpperCase();

                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child:

                          Container(
                            child: Text(' $userName'),
                          ),
                        );
                      } else {
                        return const Text('No data');
                      }
                    }),
              ),
              // CircleAvatar(
              //   backgroundImage: AssetImage('assets/assets/profile1.jpg'),
              //   backgroundColor: Colors.greenAccent,
              //   radius: 50,
              // ),
            ]),
          ),
          ListTile(
            leading: Icon(Icons.account_balance_outlined),
            title: Text('DASHBOARD'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Profile Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),


          //Sifat User type add korsi
          ListTile(
            leading: Icon(Icons.change_circle_outlined),
            title: Text('Change User Type'),
            onTap: () => {Navigator.of(context).pop()},
          ),

          //Sifat cfm add korsi
          ListTile(
            leading: Icon(Icons.announcement),
            title: Text('Call For money'),
            onTap: () => {




              //Sifat pop up


            showDialog(
                context: context,
                     builder: (BuildContext context) {
                        var DateController,AmountController;
                        return AlertDialog(
                         scrollable: true,
            title: Text('Create Call For Money'),
                   content: Padding(
                      padding: const EdgeInsets.all(8.0),
                         child: Form(
                             child: Column(
                                 children: <Widget>[
            TextFormField(
              controller: DateController,

              decoration: InputDecoration(
                   labelText: 'Amount',
                   icon: Icon(Icons.money),
                  ),
            ),


            TextFormField(
               controller: AmountController,
                   decoration: InputDecoration(
                   labelText: 'Time',
                   icon: Icon(Icons.access_time_outlined),
                 ),
            ),
            // TextFormField(
            // decoration: InputDecoration(
            // labelText: 'Message',
            // icon: Icon(Icons.message ),
            // ),
            // ),
                   ],
                ),
              ),
            ),

            actions: [
               ElevatedButton(
                   child: Text("Submit"),
                     onPressed: () {

                       Navigator.pop(context);
            // your code
                      })
                  ],
                );
            }),





              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => CFM()),
              // )

            },
          ),

          ListTile(
            leading: Icon(Icons.add_chart),
            title: Text('Transaction Statistics'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LineChartWidget.withSampleData()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('LOGOUT'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
              )
              //Navigator.of(context).pop()
            },
          ),
        ],
      ),
    );
  }
}


