
import 'package:flutter/material.dart';


class poster extends StatefulWidget {
  const poster({Key? key}) : super(key: key);

  @override
  State<poster>createState() => myPoster();
}

class myPoster extends State<poster> {

   var amount,time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Call For Money Notice!'),
      ),


      body: Padding(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        padding: EdgeInsets.all(0),



        //ddddddddddddddddddddddddd

        child:SingleChildScrollView(

          child: Column(
              children:<Widget>[

                Container(
                    height: 758,


                    decoration: BoxDecoration(
                        color: Colors.green,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/assets/p.jpg')
                        )),

                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Stack(
                      children:<Widget> [



                        Container(
                            margin: EdgeInsets.all(100),
                            // padding: const EdgeInsets.all(60),
                            padding: EdgeInsets.fromLTRB(24, 500, 20, 0),
                            //   padding: EdgeInsets.only(left:75, bottom: 20, right: 20, top:130),
                            // padding: EdgeInsets.symmetric(horizontal: 110, vertical: 90),


                            child: Container(
                              width: 200, // Adjust the width as desired
                              height: 50,
                              child:FloatingActionButton.extended(
                                label: Text('Response'),
                                // <-- Text
                                backgroundColor: Colors.black87,
                                // icon:Image.asset('assets/googleimage.png',
                                //   width: 28, // Adjust the width as desired
                                //   height: 28, ),

                                onPressed: () {

                                  showDialogWithAnimation(context);

                                  //Sifat eikhane cfm

                                  // showDialog(
                                  //     context: context,
                                  //     builder: (BuildContext context) {
                                  //       var DateController,AmountController;
                                  //       return AlertDialog(
                                  //         scrollable: true,
                                  //         title: Text('Invest in CFM'),
                                  //         content: Padding(
                                  //           padding: const EdgeInsets.all(8.0),
                                  //           child: Form(
                                  //             child: Column(
                                  //               children: <Widget>[
                                  //                 TextFormField(
                                  //                   controller: AmountController,
                                  //
                                  //                   decoration: InputDecoration(
                                  //                     labelText: 'Amount',
                                  //                     icon: Icon(Icons.money),
                                  //                   ),
                                  //                 ),
                                  //
                                  //
                                  //                 TextFormField(
                                  //                   controller: DateController,
                                  //                   decoration: InputDecoration(
                                  //                     labelText: 'Retake Time',
                                  //                     icon: Icon(Icons.access_time_outlined),
                                  //                   ),
                                  //                 ),
                                  //                 // TextFormField(
                                  //                 // decoration: InputDecoration(
                                  //                 // labelText: 'Message',
                                  //                 // icon: Icon(Icons.message ),
                                  //                 // ),
                                  //                 // ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ),
                                  //
                                  //         actions: [
                                  //           ElevatedButton(
                                  //               child: Text("Submit"),
                                  //               onPressed: () {
                                  //                 // your code
                                  //               })
                                  //         ],
                                  //       );
                                  //     });



                                  //showAlertDialog(context);
                                },
                              ),
                            )


                        ),


                      ],
                    )
                ),




              ]
          ),
        ),
      ),

    );
  }



   // void showDialogWithAnimation(BuildContext context) {
   //   var dateController = TextEditingController();
   //   var amountController = TextEditingController();
   //
   //   final AnimationController controller = AnimationController(
   //     duration: const Duration(milliseconds: 500),
   //     vsync: Navigator.of(context),
   //   );
   //
   //   showDialog<void>(
   //     context: context,
   //     builder: (BuildContext context) {
   //       return Dialog(
   //         child: AnimatedBuilder(
   //           animation: controller,
   //           builder: (BuildContext context, Widget child) {
   //             return Opacity(
   //               opacity: controller.value,
   //               child: Transform.scale(
   //                 scale: controller.value,
   //                 child: child,
   //               ),
   //             );
   //           },
   //           child: Container(
   //             padding: const EdgeInsets.all(16.0),
   //             child: Column(
   //               mainAxisSize: MainAxisSize.min,
   //               children: <Widget>[
   //                 Text(
   //                   'Invest in CFM',
   //                   style: TextStyle(
   //                     fontWeight: FontWeight.bold,
   //                     fontSize: 18.0,
   //                   ),
   //                 ),
   //                 SizedBox(height: 16.0),
   //                 TextFormField(
   //                   controller: amountController,
   //                   decoration: InputDecoration(
   //                     labelText: 'Amount',
   //                     icon: Icon(Icons.money),
   //                   ),
   //                 ),
   //                 TextFormField(
   //                   controller: dateController,
   //                   decoration: InputDecoration(
   //                     labelText: 'Retake Time',
   //                     icon: Icon(Icons.access_time_outlined),
   //                   ),
   //                 ),
   //                 SizedBox(height: 16.0),
   //                 ElevatedButton(
   //                   onPressed: () {
   //                     // Handle submit
   //                     Navigator.pop(context);
   //                   },
   //                   child: Text('Submit'),
   //                 ),
   //               ],
   //             ),
   //           ),
   //         ),
   //       );
   //     },
   //   );
   //
   //   controller.forward(); // Start the animation
   // }







}




void showDialogWithAnimation(BuildContext context) {
  var dateController = TextEditingController();
  var amountController = TextEditingController();

  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()..scale(1.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Invest in CFM',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    icon: Icon(Icons.money),
                  ),
                ),
                TextFormField(
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: 'Retake Time',
                    icon: Icon(Icons.access_time_outlined),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle submit

                     Navigator.pop(context);




                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'CFM response Successful',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.deepPurple,
                      ),
                    );



                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}





  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        //Navigator.push(context, MaterialPageRoute(builder:(context)=>MenuDashboardPage()),);
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

