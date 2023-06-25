
import 'package:flutter/material.dart';




class CFM extends StatefulWidget {
  const CFM({Key? key}) : super(key: key);

  @override
  State<CFM>createState() => myCFM();
}

class myCFM extends State<CFM> {

  TextEditingController amountController = TextEditingController();
  TextEditingController DateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('A2F'),
      ),


      body: Padding(

          padding: EdgeInsets.all(25),
          child: Column(
              children:<Widget>[

                Container(


                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Stack(
                      children:<Widget> [


                        Padding(
                          //padding: EdgeInsets.all(39),
                          padding: EdgeInsets.fromLTRB(30, 60, 10, 0),
                          child: Text(
                            'Create Call For Money!',
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
                              labelText: 'Amount (TK)',
                              hintText: 'Amount',
                            ),
                          ),
                        ),



                        Padding(
                          //padding: EdgeInsets.all(39),
                          padding: EdgeInsets.fromLTRB(10, 250, 10, 0),
                          child: TextField(
                            controller: DateController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Time (Month)',
                              hintText: 'Time',
                            ),
                          ),
                        ),





                        FractionallySizedBox(

                          widthFactor: 1.5, // Adjust the width factor as desired (0.8 means 80% of the available width)
                          child: Container(
                            margin: EdgeInsets.all(100),
                            padding: EdgeInsets.fromLTRB(30, 260, 20, 0),
                            child: FloatingActionButton.extended(
                              label: Text('Create'),
                              backgroundColor: Colors.blueAccent,
                              onPressed: () {},

                            ),
                          ),
                        ),





                      ],
                    )
                ),




              ]
          )
      ),

    );
  }

}