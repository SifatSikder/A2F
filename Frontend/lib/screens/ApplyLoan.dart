// import 'package:a2f_frontend/screens/Dashboard.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import '../services/loanservices.dart';

// class ApplyLoan extends StatefulWidget {
//   final String userID;
//   final String token;
//   const ApplyLoan({super.key, required this.userID, required this.token});

//   @override
//   State<ApplyLoan> createState() => _ApplyLoanState();
// }

// {
//   "amount":50000,
//   "months":2
// }
// class _ApplyLoanState extends State<ApplyLoan> {
//   var userID, token;
//   var amount, months;
//   @override
//   void initState() {
//     super.initState();
//     userID = widget.userID;
//     token = widget.token;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//           Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
//         TextField(
//           decoration: InputDecoration(labelText: 'Loan Amount'),
          // onChanged: (value) {
          //   amount = value;
          // },
//         ),
//         TextField(
//             decoration: InputDecoration(labelText: 'Repayment Months'),
//             onChanged: (value) {
//               months = value;
//             }),
//         SizedBox(height: 10.0),
//         ElevatedButton(
//             child: Text('Apply'),
//             onPressed: () {
//               LoanService().applyLoan(amount, months, userID).then((value) {
//                 if (value.data['success']) {
//                   print(value.data);
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => MenuDashboardPage(token: token)));
//                 }
//                 Fluttertoast.showToast(
//                     msg: value.data['message'],
//                     toastLength: Toast.LENGTH_SHORT,
//                     gravity: ToastGravity.BOTTOM,
//                     timeInSecForIosWeb: 3,
//                     backgroundColor: Colors.purple,
//                     textColor: Colors.white,
//                     fontSize: 16.0);
//               });
//             },
//             style: ElevatedButton.styleFrom(primary: Colors.blue)),
//         ElevatedButton(
//             child: const Text('Back'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             style: ElevatedButton.styleFrom(primary: Colors.blue)),
//       ]),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';


import '../screens/Dashboard.dart';
import '../services/loanservices.dart';

class ApplyLoan extends StatefulWidget {
  final String userID;
  final String token;
  const ApplyLoan({super.key, required this.userID, required this.token});
  @override
  State<ApplyLoan> createState() => my_LoanApply();
}

// {
//   "amount":50000,
//   "months":2
// }
class my_LoanApply extends State<ApplyLoan> {
  var userID, token;
  var amount, months;
  @override
  void initState() {
    super.initState();
    userID = widget.userID;
    token = widget.token;
  }

  TextEditingController amountController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  // String dropdownValue = ' ';
  // String selectedValue = 'Item 1';
  // List<String> items = ['Item 1', 'Item 2', 'Item 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A2F'),
      ),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
                height: 758,
                decoration: BoxDecoration(
                    color: Colors.green,
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage('assets/assets/b2.jpg'))),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(80, 0, 10, 0),
                      child: Text(
                        'Apply for Loan',
                        style: TextStyle(
                          fontFamily: "Font2",
                          fontSize: 35,
                          color: Colors.blueAccent[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 80, 10, 0),
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
                      padding: const EdgeInsets.fromLTRB(10, 170, 10, 0),
                      child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Loan Period(in Months)',
                            hintText: 'Repayment Months',
                          ),
                          onChanged: (value) {
                            months = value;
                          }),
                    ),
                    Container(
                        margin: EdgeInsets.all(100),
                        padding: EdgeInsets.fromLTRB(30, 170, 20, 0),
                        child: Container(
                          width: 200, // Adjust the width as desired
                          height: 50,
                          child: FloatingActionButton.extended(
                            label: Text('Submit'),
                            backgroundColor: Colors.blueAccent,
                            onPressed: () {
                              print(amount + months + userID);
                              LoanService()
                                  .applyLoan(amount, months, userID,context)
                                  .then((value) {
                                if (value.data['success']) {
                                  print(value.data);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          MenuDashboardPage(token: token)));
                                }
                                // Fluttertoast.showToast(
                                //     msg: value.data['message'],
                                //     toastLength: Toast.LENGTH_SHORT,
                                //     gravity: ToastGravity.TOP,
                                //     timeInSecForIosWeb: 3,
                                //     backgroundColor: Colors.purple,
                                //     textColor: Colors.white,
                                //     fontSize: 16.0);

                                final snackBar = SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.only(bottom: 450.0),
                                  content:
                                      Text(value.data['message'].toString()),
                                  backgroundColor: (Colors.deepPurple),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);

                              });
                            },
                          ),
                        )),
                  ],
                )),
          ]),
        ),
      ),
    );
  }
}
