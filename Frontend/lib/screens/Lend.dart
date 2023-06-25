import 'package:flutter_application_1/screens/Dashboard.dart';

import '../Forms/LoanFeed.dart';
import '../services/loanservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


class Lend extends StatefulWidget {
  final String loanId;
  final String recepientId;
  final String amount;
  final String satisfiedAmount;
  final String repaymentMonths;
  final String loanStatus;
  final String loanEmi;
  final String loanProvidedBy;
  final String contributorID;
  final String token;
  const Lend(
      {super.key,
      required String this.loanId,
      required String this.recepientId,
      required String this.amount,
      required String this.satisfiedAmount,
      required String this.repaymentMonths,
      required String this.loanStatus,
      required String this.loanEmi,
      required String this.loanProvidedBy,
      required String this.contributorID,
      required String this.token});

  @override
  State<Lend> createState() => _LendState();
}

class _LendState extends State<Lend> {
  var loanId;
  var recepientId;
  var amount;
  var satisfiedAmount;
  var repaymentMonths;
  var loanStatus;
  var loanEmi;
  var loanProvidedBy;
  var contributorID;
  var token;

  var donatedAmount;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loanId = widget.loanId;
    recepientId = widget.recepientId;
    amount = widget.amount;
    satisfiedAmount = widget.satisfiedAmount;
    repaymentMonths = widget.repaymentMonths;
    loanStatus = widget.loanStatus;
    loanEmi = widget.loanEmi;
    loanProvidedBy = widget.loanProvidedBy;
    contributorID = widget.contributorID;
    token = widget.token;
  }

  TextEditingController amountController = TextEditingController();

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
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        //padding: EdgeInsets.all(39),
                        padding: EdgeInsets.fromLTRB(20, 60, 10, 0),
                        child: Text(
                          'Amount you want to lend',
                          style: TextStyle(
                            fontFamily: "Font2",
                            fontSize: 24,
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
                              donatedAmount = value;
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
                              await LoanService()
                                  .contributeToALoan(
                                      donatedAmount, contributorID, loanId, context)
                                  .then((response) => {
                                        if (response.data['success'])
                                          {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MenuDashboardPage(

                                                            token: token)))
                                          },




                                        // Fluttertoast.showToast(
                                        //     msg: response.data['message'],
                                        //     toastLength: Toast.LENGTH_SHORT,
                                        //     gravity: ToastGravity.TOP,
                                        //     timeInSecForIosWeb: 3,
                                        //     backgroundColor: Colors.purple,
                                        //     textColor: Colors.white,
                                        //     fontSize: 16.0)

                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                              content: Text(
                              response.data['message'],
                              style: TextStyle(color: Colors.white, fontSize: 16.0),
                              ),
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.purple,
                              behavior: SnackBarBehavior.floating,
                              ),
                              ),

                              });
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
