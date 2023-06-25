import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoanService {
  Dio dio = new Dio();
  // String base_address = 'http://192.168.140.188:8000';
  // String base_address='http://10.0.2.2:8000';
  String base_address = 'http://localhost:8000';

//apply loan credential
// {
//   "amount":50000,
//   "months":2
// }

  applyLoan(amount, months, userID, BuildContext context) async {
    try {
      return await dio.post('${base_address}/loan/$userID/apply-new-loan',
          data: {"amount": int.parse(amount), "months": int.parse(months)},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.response?.data['msg'] ?? 'An error occurred',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.deepPurple,
        ),
      );

      // Fluttertoast.showToast(
      //     msg: e.response?.data['msg'],
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.purple,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
      //
    }
  }

  contributeToALoan(
      donatedAmount, contributorID, loanId, BuildContext context) async {
    try {
      print('code is here');
      print((donatedAmount));
      return await dio.post(
          '${base_address}/loan/$contributorID/$loanId/contribute-to-a-loan',
          data: {"amount": int.parse(donatedAmount)},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      //     msg: e.response?.data['msg'],
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.purple,
      //     textColor: Colors.white,
      //     fontSize: 16.0);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.response?.data['msg'] ?? 'An error occurred',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.deepPurple,
        ),
      );
    }
  }

  repayLoan(repayAmount, userID, BuildContext context) async {
    try {
      print(int.parse(repayAmount));
      return await dio.post('${base_address}/loan/$userID/repay-loan',
          data: {"amount": int.parse(repayAmount)},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      //     msg: e.response?.data['msg'],
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.purple,
      //     textColor: Colors.white,
      //     fontSize: 16.0);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.response?.data['msg'] ?? 'An error occurred',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.deepPurple,
        ),
      );
    }
  }

  getLoanLists(userID) async {
    return await dio.get('$base_address/loan/$userID/list-of-all-loans');
  }

  transactionList(userID) async{
    return await dio.get('$base_address/user/$userID/transaction-list');
  }

  completeWithdrawal(userID, String withdrawID) async{
    return await dio.get('$base_address/user/$userID/$withdrawID/complete-a-withdraw-request');
  }
}
