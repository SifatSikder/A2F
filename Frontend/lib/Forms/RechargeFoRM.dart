// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCAdditionalInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCCustomerInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCEMITransactionInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCShipmentInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/General.dart';
import 'package:flutter_sslcommerz/model/sslproductinitilizer/SSLCProductInitializer.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

import '../screens/Dashboard.dart';
import '../services/authServices.dart';
// import 'package:fluttertoast/fluttertoast.dart';

enum SdkType { TESTBOX, LIVE }

class Recharge extends StatefulWidget {
  final String userID;
  final String token;
  Recharge(this.userID, this.token, {super.key});

  @override
  _RechargeState createState() => _RechargeState();
}

class _RechargeState extends State<Recharge> {
  var _key = GlobalKey<FormState>();
  var userID;
  var token;
  dynamic formData = {};
  SdkType _radioSelected = SdkType.TESTBOX;

  @override
  void initState() {
    super.initState();
    userID = widget.userID;
    token = widget.token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A2F'),
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                //padding: EdgeInsets.all(39),
                                padding: EdgeInsets.fromLTRB(55, 50, 10, 0),
                                child: Text(
                                  'Recharge Wallet',
                                  style: TextStyle(
                                    fontFamily: "Font2",
                                    fontSize: 25,
                                    color: Colors.blueAccent[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                  //textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(30, 120, 10, 0),
                                // padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
                                    hintText: "Payment amount",
                                  ),
                                  validator: (value) {
                                    if (value != null)
                                      return "Please input amount";
                                    else
                                      return null;
                                  },
                                  onSaved: (value) {
                                    formData['amount'] = double.parse(value!);
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(30, 210, 10, 0),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
                                    hintText: "Phone number",
                                  ),
                                  onSaved: (value) {
                                    formData['phone'] = value;
                                  },
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor:
                                    1.5, // Adjust the width factor as desired (0.8 means 80% of the available width)
                                child: Container(
                                  margin: EdgeInsets.all(100),
                                  padding: EdgeInsets.fromLTRB(18, 200, 0, 0),
                                  child: FloatingActionButton.extended(
                                    label: Text('Cash-In with SSLCommerz'),
                                    backgroundColor: Colors.blueAccent,
                                    onPressed: () {
                                      if (_key.currentState != null) {
                                        _key.currentState?.save();
                                        print(_radioSelected);
                                        sslCommerzGeneralCall();
                                        // sslCommerzCustomizedCall();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sslCommerzGeneralCall() async {
    formData['store_id'] = 'a2f63f505de33c30';
    formData['store_password'] = 'a2f63f505de33c30@ssl';
    formData['multicard'] = 'VISA';
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        //Use the ipn if you have valid one, or it will fail the transaction.
        ipn_url: "www.ipnurl.com",
        multi_card_name: formData['multicard'],
        currency: SSLCurrencyType.BDT,
        product_category: "Food",
        sdkType: _radioSelected == SdkType.TESTBOX
            ? SSLCSdkType.TESTBOX
            : SSLCSdkType.LIVE,
        store_id: formData['store_id'],
        store_passwd: formData['store_password'],
        total_amount: formData['amount'],
        tran_id: "1231123131212",
      ),
    );
    try {
      SSLCTransactionInfoModel result = await sslcommerz.payNow();

      print(result.status!.toLowerCase());
      if (result.status!.toLowerCase() == "failed") {
        // Fluttertoast.showToast(
        //     msg: "Transaction is Failed....",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 16.0);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Transaction is Failed....',
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 1),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        // Fluttertoast.showToast(
        //     msg:
        //         "Transaction is ${result.status} and Amount is ${result.amount}",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white,
        //     fontSize: 16.0);

        double a = (formData['amount']);
        print(a);

        await AuthService().cashIn(userID, a.toInt(), context).then((response) {
          if (response.data['success']) {
            print(token);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "$response.data['message']",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.purple,
              ),
            );

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MenuDashboardPage(token: token)));
          }
        });

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(
        //       'Transaction is ${result.status} and Amount is ${result.amount}',
        //       style: TextStyle(color: Colors.white),
        //     ),
        //     duration: Duration(seconds: 1),
        //     backgroundColor: Colors.green,
        //   ),
        // );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> sslCommerzCustomizedCall() async {
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        //Use the ipn if you have valid one, or it will fail the transaction.
        ipn_url: "www.ipnurl.com",
        multi_card_name: formData['multicard'],
        currency: SSLCurrencyType.BDT,
        product_category: "Food",
        sdkType: SSLCSdkType.LIVE,
        store_id: formData['store_id'],
        store_passwd: formData['store_password'],
        total_amount: formData['amount'],
        tran_id: "1231321321321312",
      ),
    );

    sslcommerz
        .addEMITransactionInitializer(
            sslcemiTransactionInitializer: SSLCEMITransactionInitializer(
                emi_options: 1, emi_max_list_options: 9, emi_selected_inst: 0))
        .addShipmentInfoInitializer(
            sslcShipmentInfoInitializer: SSLCShipmentInfoInitializer(
                shipmentMethod: "yes",
                numOfItems: 5,
                shipmentDetails: ShipmentDetails(
                    shipAddress1: "Ship address 1",
                    shipCity: "Faridpur",
                    shipCountry: "Bangladesh",
                    shipName: "Ship name 1",
                    shipPostCode: "7860")))
        .addCustomerInfoInitializer(
          customerInfoInitializer: SSLCCustomerInfoInitializer(
            customerState: "Chattogram",
            customerName: "Abu Sayed Chowdhury",
            customerEmail: "sayem227@gmail.com",
            customerAddress1: "Anderkilla",
            customerCity: "Chattogram",
            customerPostCode: "200",
            customerCountry: "Bangladesh",
            customerPhone: formData['phone'],
          ),
        )
        .addProductInitializer(
            sslcProductInitializer:
                // ***** ssl product initializer for general product STARTS*****
                SSLCProductInitializer(
          productName: "Water Filter",
          productCategory: "Widgets",
          general: General(
            general: "General Purpose",
            productProfile: "Product Profile",
          ),
        )
            // ***** ssl product initializer for general product ENDS*****

            // ***** ssl product initializer for non physical goods STARTS *****
            // SSLCProductInitializer.WithNonPhysicalGoodsProfile(
            //     productName:
            //   "productName",
            //   productCategory:
            //   "productCategory",
            //   nonPhysicalGoods:
            //   NonPhysicalGoods(
            //      productProfile:
            //       "Product profile",
            //     nonPhysicalGoods:
            //     "non physical good"
            //       ))
            // ***** ssl product initializer for non physical goods ENDS *****

            // ***** ssl product initialization for travel vertices STARTS *****
            //       SSLCProductInitializer.WithTravelVerticalProfile(
            //          productName:
            //         "productName",
            //         productCategory:
            //         "productCategory",
            //         travelVertical:
            //         TravelVertical(
            //               productProfile: "productProfile",
            //               hotelName: "hotelName",
            //               lengthOfStay: "lengthOfStay",
            //               checkInTime: "checkInTime",
            //               hotelCity: "hotelCity"
            //             )
            //       )
            // ***** ssl product initialization for travel vertices ENDS *****

            // ***** ssl product initialization for physical goods STARTS *****

            // SSLCProductInitializer.WithPhysicalGoodsProfile(
            //     productName: "productName",
            //     productCategory: "productCategory",
            //     physicalGoods: PhysicalGoods(
            //         productProfile: "Product profile",
            //         physicalGoods: "non physical good"))

            // ***** ssl product initialization for physical goods ENDS *****

            // ***** ssl product initialization for telecom vertice STARTS *****
            // SSLCProductInitializer.WithTelecomVerticalProfile(
            //     productName: "productName",
            //     productCategory: "productCategory",
            //     telecomVertical: TelecomVertical(
            //         productProfile: "productProfile",
            //         productType: "productType",
            //         topUpNumber: "topUpNumber",
            //         countryTopUp: "countryTopUp"))
            // ***** ssl product initialization for telecom vertice ENDS *****
            )
        .addAdditionalInitializer(
          sslcAdditionalInitializer: SSLCAdditionalInitializer(
            valueA: "value a ",
            valueB: "value b",
            valueC: "value c",
            valueD: "value d",
          ),
        );

    try {
      SSLCTransactionInfoModel result = await sslcommerz.payNow();

      if (result.status!.toLowerCase() == "failed") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Transaction is Failed....',
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 1),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Transaction is ${result.status} and Amount is ${result.amount}',
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 1),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
