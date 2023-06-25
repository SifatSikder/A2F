import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthService {
  Dio dio = new Dio();
  //  String base_address='http://192.168.140.188:8000';
  // String base_address = 'http://10.0.2.2:8000';
  String base_address = 'http://localhost:8000';

//registration credential
// {
//   "email":"bsse1223@iit.du.ac.bd",
//   "password":"1234",
//   "username":"sifat",
//   "UniversityRegistrationID":"2019316864",
//   "PhoneNumber":"01987959788",
//   "bKashNumber":"01987959788",
//   "currentBsseYear":"3rd"
// }
  register(email, password, username, UniversityRegistrationID, PhoneNumber,
      bKashNumber, currentBsseYear, BuildContext context) async {
    try {
      return await dio.post('$base_address/user/new',
          data: {
            "email": email,
            "password": password,
            "username": username,
            "UniversityRegistrationID": UniversityRegistrationID,
            "PhoneNumber": PhoneNumber,
            "bKashNumber": bKashNumber,
            "currentBsseYear": currentBsseYear
          },
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

  login(email, password, BuildContext context) async {
    try {
      print(email + password);
      return await dio.post('${base_address}/user/login',
          data: {"email": email, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);

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
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  getInfo(token) async {
    dio.options.headers['Authorization'] = 'Bearer $token';
    return await dio.get('$base_address/user/dashboard');
  }

  cashIn(userID, amount, BuildContext context) async {
    print('hello');
    print(amount.runtimeType);
    try {
      return await dio.post('$base_address/user/$userID/cash-in',
          data: {"amount": (amount)},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);

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
            e.response?.data['message'] ?? 'An error occurred',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.deepPurple,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

// {
//   "amount":10,
//   "platformName":"bKash",
//   "platformNumber":"01987959788"
// }

  cashOut(userID, amount, platformName, platformNumber, context) async {
    try {
      return await dio.post('$base_address/user/$userID/cash-out',
          data: {
            "amount": int.parse(amount),
            "platformName": platformName,
            "platformNumber": platformNumber
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);

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
            e.response?.data['message'] ?? 'An error occurred',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.deepPurple,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  callForMoneyCreation(String userID, amount, time, BuildContext context) async {

     amount=int.parse(amount);
     time=int.parse(time);
     try {
      return await dio.post('$base_address/admin/$userID/createCFM',
          data: {
            "amount": amount,
            "date":time,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      //     msg: e.response?.data['msg'],
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.purple,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
      print(e);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.response?.data['message'] ?? 'An error occurred',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.deepPurple,
        ),
      );
    }



  }
}
