// ignore: file_names
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/IncompleteWithdrawals.dart';
import '../models/LoanList.dart';
import '../screens/Lend.dart';
import '../services/authServices.dart';
import '../services/loanservices.dart';

class WithdrawalList extends StatefulWidget {
  final String userID;
  
  const WithdrawalList({super.key, required this.userID});

  @override
  State<WithdrawalList> createState() => _WithdrawalListState();
}

class _WithdrawalListState extends State<WithdrawalList> {
  var userID;

  late Future<IncompleteWithdrawals> incompleteWithdrawals;

  @override
  void initState() {
    super.initState();
    userID = widget.userID;
    incompleteWithdrawals = getIncompleteWithdrawals();
  }

  Future<IncompleteWithdrawals> getIncompleteWithdrawals() async {
    Response response = await LoanService().transactionList(userID);
    var data = await jsonDecode(response.toString());
    return IncompleteWithdrawals.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Pending Withdrawals'),),
        body: SingleChildScrollView(
            child: Row(children: 
            <Widget>[Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Card(
                      elevation: 3,
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(children: <Widget>[
                            FutureBuilder<IncompleteWithdrawals>(
                                future: incompleteWithdrawals,
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) 
                                  {
                                    return Text('${snapshot.error}');
                                  } 
                                  else if (snapshot.hasData) 
                                  {
                                    if (!snapshot.data!.success) 
                                    {
                                      var message= snapshot.data!.message;
                                      return  SnackBar
                                              (
                                                content: Text(message,style: const TextStyle(color: Colors.white, fontSize: 16.0),),
                                                duration: const Duration(seconds: 1),
                                                backgroundColor: Colors.deepPurple,
                                              );
                        
                                    } 
                                    else if(snapshot.data!.success && snapshot.data!.transactions.isEmpty) 
                                    {
                                      return const Center(child: Text('No Incomplete Withdrawals'));
          
                                    }
                                    else
                                    {
                                      return ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.transactions.length,
                                        itemBuilder: (context, index) {
                                          final item =snapshot.data!.transactions[index];

                                          return Card(
                                            elevation: 50,
                                            shadowColor: Colors.black,
                                            child:Column(children: [
                                              Padding(padding:const EdgeInsets.all(8.0),child:Text('Withdrawer ID:${item.withdrawerId}'),),
                                              Padding(padding:const EdgeInsets.all(8.0),child: Text('Cash Out Amount: ${item.cashOutAmount}'),),
                                              Padding(padding:const EdgeInsets.all(8.0),child: Text('Withdrawal Platform: ${item.withdrawPlatformName}'),),
                                              Padding(padding:const EdgeInsets.all(8.0),child: Text('Platform Credentials: ${item.withdrawPlatformNumber}'),),
                          
                                      
                                              Padding(padding:const EdgeInsets.all(8.0),
                                                child: ElevatedButton(
                                                    onPressed: () async{
                                                      var withdrawID= item.id;
                                                      var response = await LoanService().completeWithdrawal(userID,withdrawID);
                                                      SnackBar
                                                      (
                                                        content: Text(response.data['message'],style: const TextStyle(color: Colors.white, fontSize: 16.0),),
                                                        duration: const Duration(seconds: 1),
                                                        backgroundColor: Colors.deepPurple,
                                                      );
                                                      Navigator.push(context,MaterialPageRoute(builder: (context) => WithdrawalList(userID: userID,)),);
                                                    },
                                                    style: ElevatedButton.styleFrom(primary:Colors.blue),
                                                    child: const Text('Mark as complete')
                                                ),
                                              ),
                                            ],
                                          ),);
                                          

                                        },
                                      );
                                    }
                                  }
                                  return const CircularProgressIndicator();
                                }),
                          ])))))
        ])));
  }
}
