
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class fundForm extends StatefulWidget {
  const fundForm({Key? key}) : super(key: key);

  @override
  State<fundForm>createState() => _myfundForm();
}

class _myfundForm extends State<fundForm> {

  TextEditingController amountController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  XFile? image;
  final ImagePicker picker=ImagePicker();


  //Sifat ekhane upload doc er jonno photo upload korsi
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }



  //alert box

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }




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


                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: Stack(
                          children:<Widget> [


                            Padding(
                              //padding: EdgeInsets.all(39),
                              padding: EdgeInsets.fromLTRB(35, 60, 10, 0),
                              child: Text(
                                'Apply for Fundraising',
                                style: TextStyle(
                                  fontFamily: "Font2",
                                  fontSize: 26,
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
                                  labelText: 'How much money do you want?',
                                  hintText: 'Amount',
                                ),
                              ),
                            ),

                            Padding(
                              //padding: EdgeInsets.all(39),
                              padding: EdgeInsets.fromLTRB(10, 255, 10, 0),
                              child: TextField(
                                controller: reasonController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'State the reason in short',
                                  hintText: 'Reason for application',
                                ),
                              ),
                            ),

                            Padding(
                              padding:EdgeInsets.fromLTRB(88, 350, 10, 0),
                              child:ElevatedButton(
                                onPressed: () {
                                  myAlert();
                                },
                                child: Text('Upload Documents'),
                              ),

                            ),

                            SizedBox(
                              height: 10,
                            ),
                            //if image not null show the image
                            //if image null show text
                            image != null
                                ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  //to show image, you type like this.
                                  File(image!.path),
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: 300,
                                ),
                              ),
                            )
                                : Text(
                              "",
                              style: TextStyle(fontSize: 20),
                            ),









                            FractionallySizedBox(
                              widthFactor: 1.2, // Adjust the width factor as desired (0.8 means 80% of the available width)
                              child: Container(
                                margin: EdgeInsets.all(100),
                                padding: EdgeInsets.fromLTRB(30, 350, 20, 0),
                                child: FloatingActionButton.extended(
                                  label: Text('Submit'),
                                  backgroundColor: Colors.blueAccent,
                                  onPressed: () {
                                    Navigator.pop(context);

                                  },
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
        )

    );
  }

}