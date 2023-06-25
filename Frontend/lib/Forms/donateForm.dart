
import 'package:flutter/material.dart';




class DonateForm extends StatefulWidget {
  const DonateForm({Key? key}) : super(key: key);

  @override
  State<DonateForm>createState() => _myRecharge();
}

class _myRecharge extends State<DonateForm> {

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
          child: Column(
              children:<Widget>[

                Container(
                  // height: 1000,
                  // decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       image: AssetImage('assets/assets/form.jpg'),
                  //
                  //       fit: BoxFit.cover,
                  //
                  //     )
                  // ),

                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Stack(
                      children:<Widget> [


                        Padding(
                          //padding: EdgeInsets.all(39),
                          padding: EdgeInsets.fromLTRB(35, 60, 10, 0),
                          child: Text(
                            'Donate for Welfare',
                            style: TextStyle(
                              fontFamily: "Font2",
                              fontSize: 30,
                              color: Colors.blueAccent[700],
                              fontWeight: FontWeight.bold,
                            ),
                            //textAlign: TextAlign.center,
                          ),
                        ),


                        // Text(
                        //
                        //   'Recharge Your Wallet',
                        //   style: TextStyle(
                        //     fontSize: 35,
                        //     foreground: Paint()
                        //       ..style = PaintingStyle.stroke
                        //       ..strokeWidth = 6
                        //       ..color = Colors.blue[700]!,
                        //   ),
                        //
                        //   textAlign: TextAlign.center,
                        // ),
                        // // Solid text as fill.
                        // Text(
                        //   'Recharge Your Wallet',
                        //   style: TextStyle(
                        //     fontSize: 35,
                        //     color: Colors.grey[300],
                        //
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),


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
                          widthFactor: 1.5, // Adjust the width factor as desired (0.8 means 80% of the available width)
                          child: Container(
                            margin: EdgeInsets.all(100),
                            padding: EdgeInsets.fromLTRB(30, 180, 20, 0),
                            child: FloatingActionButton.extended(
                              label: Text('Donate'),
                              backgroundColor: Colors.blueAccent,
                              onPressed: () {},
                            ),
                          ),
                        ),




                        // Container(
                        //     margin: EdgeInsets.all(39),
                        //     // padding: const EdgeInsets.all(60),
                        //     padding: EdgeInsets.fromLTRB(84, 100, 20, 20),
                        //     //   padding: EdgeInsets.only(left:75, bottom: 20, right: 20, top:130),
                        //     // padding: EdgeInsets.symmetric(horizontal: 110, vertical: 90),
                        //
                        //     child: ElevatedButton(
                        //       child: const Text('Cash-in with SSLCommerz'),
                        //       onPressed: () {
                        //
                        //             String amt=amountController.text;
                        //             print(amt);
                        //             Navigator.pop(context,amt);
                        //
                        //
                        //       },
                        //     )
                        //
                        // ),



                      ],
                    )
                ),




              ]
          )
      ),
    ),

    );
  }

}