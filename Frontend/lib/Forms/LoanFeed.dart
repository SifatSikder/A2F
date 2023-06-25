// ignore: file_names
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/LoanList.dart';
import '../screens/Lend.dart';
import '../services/authServices.dart';
import '../services/loanservices.dart';

class AllLoans extends StatefulWidget {
  final String userID;
  final String token;
  const AllLoans({super.key, required this.userID, required this.token});

  @override
  State<AllLoans> createState() => _AllLoansState();
}

class _AllLoansState extends State<AllLoans> {
  var userID, token;

  late Future<LoanList> loanList;

  @override
  void initState() {
    super.initState();
    userID = widget.userID;
    token = widget.token;
    loanList = getLoanLists();
  }

  Future<LoanList> getLoanLists() async {
    Response response = await LoanService().getLoanLists(userID);
    var data = await jsonDecode(response.toString());
    return LoanList.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('A2F'),
        ),
        body: SingleChildScrollView(
            child: Row(children: <Widget>[
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Card(
                      elevation: 3,
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(children: <Widget>[
                            FutureBuilder<LoanList>(
                                future: loanList,
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    if (snapshot.data!.loans.isEmpty) {
                                      return const Center(
                                          child: Text('No Pending Loans'));
                                    } else {
                                      return ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.loans.length,
                                        itemBuilder: (context, index) {
                                          final item =
                                              snapshot.data!.loans[index];

                                          return Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child:
                                                    Text('Loan ID:${item.id}'),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    'Loan Amount: ${item.loanAmount}'),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    'Satisfied till now: ${item.satisfiedAmount}'),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    'Loan Repayment Months: ${item.repaymentMonths}'),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context).push(MaterialPageRoute(
                                                          builder: (context) => Lend(
                                                              loanId: item.id
                                                                  .toString(),
                                                              recepientId: item
                                                                  .recepientId
                                                                  .toString(),
                                                              amount: item.loanAmount
                                                                  .toString(),
                                                              satisfiedAmount: item
                                                                  .satisfiedAmount
                                                                  .toString(),
                                                              repaymentMonths: item
                                                                  .repaymentMonths
                                                                  .toString(),
                                                              loanStatus: item
                                                                  .loanStatus
                                                                  .toString(),
                                                              loanEmi: item.loanEmi
                                                                  .toString(),
                                                              loanProvidedBy:
                                                                  item.loanProvidedBy.toString(),
                                                              contributorID: userID,
                                                              token: token)));
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.blue),
                                                    child: const Text('Lend')),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }
                                  return const CircularProgressIndicator();
                                }),
                          ])))))
        ])));
  }
}
