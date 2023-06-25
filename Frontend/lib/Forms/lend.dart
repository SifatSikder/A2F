import 'package:flutter/material.dart';

import '../screens/Dashboard.dart';

class Lend extends StatefulWidget {
  const Lend({Key? key}) : super(key: key);

  @override
  State<Lend> createState() => _myLend();
}

class _myLend extends State<Lend> {
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
                            fontSize: 27,
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
                          controller: amountController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Amount',
                            hintText: 'Amount',
                          ),
                        ),
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
                            onPressed: () {},
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
