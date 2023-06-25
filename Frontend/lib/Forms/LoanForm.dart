import 'package:flutter/material.dart';

import 'package:awesome_dialog/awesome_dialog.dart';

import '../screens/Dashboard.dart';

class LoanApply extends StatefulWidget {
  const LoanApply({Key? key}) : super(key: key);

  @override
  State<LoanApply> createState() => my_LoanApply();
}

class my_LoanApply extends State<LoanApply> {
  TextEditingController amountController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  // Initial Selected Value
  String dropdownValue = ' ';
  String selectedValue = 'Item 1';
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A2F'),
      ),
      body: Padding(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        padding: EdgeInsets.all(0),

        //ddddddddddddddddddddddddd

        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
                height: 758,
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage('assets/form.jpg'),
                //
                //       fit: BoxFit.cover,
                //
                //     )
                // ),

                decoration: BoxDecoration(
                    color: Colors.green,
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage('assets/b2.jpg'))),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: <Widget>[
                    //
                    // Text(
                    //   'Apply for Loan',
                    //   style: TextStyle(
                    //     fontSize: 35,
                    //     color: Colors.blueAccent[700],
                    //
                    //   ),
                    //   textAlign: TextAlign.center,
                    // ),

                    Padding(
                      //padding: EdgeInsets.all(39),
                      padding: EdgeInsets.fromLTRB(80, 0, 10, 0),
                      child: Text(
                        'Apply for Loan',
                        style: TextStyle(
                          fontFamily: "Font2",
                          fontSize: 35,
                          color: Colors.blueAccent[700],
                          fontWeight: FontWeight.bold,
                        ),
                        //textAlign: TextAlign.center,
                      ),
                    ),

                    Padding(
                      //padding: EdgeInsets.all(39),
                      padding: EdgeInsets.fromLTRB(10, 80, 10, 0),

                      child: TextField(
                        controller: amountController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Amount',
                          hintText: 'Amount',
                        ),
                      ),
                    ),

                    Padding(
                      //padding: EdgeInsets.all(39),
                      padding: EdgeInsets.fromLTRB(10, 170, 10, 0),
                      child: TextField(
                        //controller: timeController,

                        decoration: InputDecoration(
                          labelText: 'Time',
                          // border: OutlineInputBorder(
                          //  borderSide: BorderSide(),
                          // ),

                          enabledBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.zero,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.zero,
                          ),

                          // hintText: 'Time',

                          suffixIcon: DropdownButtonFormField(
                            value: selectedValue,
                            onChanged: (newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                            items: items
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),

                    // Padding(
                    //
                    //   padding: EdgeInsets.fromLTRB(10, 170, 10, 0),
                    //
                    //
                    //
                    //           child:   DropdownButtonFormField(
                    //                decoration: InputDecoration(
                    //                  enabledBorder: OutlineInputBorder( //<-- SEE HERE
                    //                    borderSide: BorderSide(color: Colors.black, width: 0),
                    //                  ),
                    //                  focusedBorder: OutlineInputBorder( //<-- SEE HERE
                    //                    borderSide: BorderSide(color: Colors.black, width: 2),
                    //                  ),
                    //                  filled: true,
                    //                  fillColor: Colors.greenAccent,
                    //                ),
                    //                dropdownColor: Colors.greenAccent,
                    //                value: dropdownValue,
                    //                onChanged: (String? newValue) {
                    //                  setState(() {
                    //                    dropdownValue = newValue!;
                    //                  });
                    //                },
                    //                items: <String>['Dog', 'Cat', 'Tiger', 'Lion'].map<DropdownMenuItem<String>>((String value) {
                    //                  return DropdownMenuItem<String>(
                    //                    value: value,
                    //                    child: Text(
                    //                      value,
                    //                      style: TextStyle(fontSize: 20),
                    //                    ),
                    //                  );
                    //                }).toList(),
                    //              ),
                    //
                    // ),
                    //

                    Container(
                        margin: EdgeInsets.all(100),
                        // padding: const EdgeInsets.all(60),
                        padding: EdgeInsets.fromLTRB(30, 170, 20, 0),
                        //   padding: EdgeInsets.only(left:75, bottom: 20, right: 20, top:130),
                        // padding: EdgeInsets.symmetric(horizontal: 110, vertical: 90),

                        child: Container(
                          width: 200, // Adjust the width as desired
                          height: 50,
                          child: FloatingActionButton.extended(
                            label: Text('Submit'),
                            // <-- Text
                            backgroundColor: Colors.blueAccent,
                            // icon:Image.asset('assets/googleimage.png',
                            //   width: 28, // Adjust the width as desired
                            //   height: 28, ),

                            onPressed: () {
                              showAlertDialog(context);
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

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MenuDashboardPage(
                    token: '',
                  )),
        );
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Post Submitted Successfully!"),
      content: Text("Wait until further response is sent"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}


//aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa