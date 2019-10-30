import 'package:flutter/material.dart';
import 'package:flutter_firebase/firebase/auth/phone_auth_widgets.dart';
import 'package:flutter_firebase/utils/constants.dart';

import '../../pin_test.dart';

// ignore: must_be_immutable
class PhoneAuthVerify extends StatefulWidget {
  /*
   *  cardBackgroundColor & logo values will be passed to the constructor
   *  here we access these params in the _PhoneAuthState using "widget"
   */
  Color cardBackgroundColor = Color(0xFFFCA967);
  String logo = Assets.firebase;
  String appName = "Awesome app";

  @override
  _PhoneAuthVerifyState createState() => _PhoneAuthVerifyState();
}

class _PhoneAuthVerifyState extends State<PhoneAuthVerify> {
  double _height, _width, _fixedPadding;

  @override
  Widget build(BuildContext context) {
    //  Fetching height & width parameters from the MediaQuery
    //  _logoPadding will be a constant, scaling it according to device's size
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _fixedPadding = _height * 0.025;

    /*
     *  Scaffold: Using a Scaffold widget as parent
     *  SafeArea: As a precaution - wrapping all child descendants in SafeArea, so that even notched phones won't loose data
     *  Center: As we are just having Card widget - making it to stay in Center would really look good
     *  SingleChildScrollView: There can be chances arising where
     */
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: _getBody(),
          ),
        ),
      ),
    );
  }

  /*
   *  Widget hierarchy ->
   *    Scaffold -> SafeArea -> Center -> SingleChildScrollView -> Card()
   *    Card -> FutureBuilder -> Column()
   */
  Widget _getBody() => Card(
        color: widget.cardBackgroundColor,
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Container(
          height: _height * 8 / 10,
          width: _width * 8 / 10,
          child: _getColumnBody(),
        ),
      );

  FocusNode focusNode = FocusNode();
  String code = "";

  Widget _getColumnBody() => Column(
        children: <Widget>[
          //  Logo: scaling to occupy 2 parts of 10 in the whole height of device
          Padding(
            padding: EdgeInsets.all(_fixedPadding),
            child: PhoneAuthWidgets.getLogo(
                logoPath: widget.logo, height: _height * 0.2),
          ),

          // AppName:
          Text(widget.appName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700)),

          SizedBox(height: 20.0),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              getField("1"),
              SizedBox(width: 5.0),
              getField("2"),
              SizedBox(width: 5.0),
              getField("3"),
              SizedBox(width: 5.0),
              getField("4"),
              SizedBox(width: 5.0),
              getField("5"),
              SizedBox(width: 5.0),
              getField("6"),
              SizedBox(width: 5.0),
            ],
          )
        ],
      );

  Widget getField(String key) => SizedBox(
        height: 45.0,
        width: 45.0,
        child: TextFormField(
          key: Key(key),
          expands: false,
          autofocus: key.contains("1") ? true : false,
          focusNode: focusNode,
          autovalidate: true,
          onChanged: (String value) {
            if (value.length == 1) {
              code += value;
              if (key.contains("6"))
                focusNode.unfocus();
              else
                focusNode.nextFocus();
            }
          },
          maxLengthEnforced: false,
          textAlign: TextAlign.center,
          cursorColor: Colors.white,
          keyboardType: TextInputType.number,
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                  bottom: 10.0, top: 10.0, left: 4.0, right: 4.0),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide:
                      BorderSide(color: Colors.blueAccent, width: 2.25)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.white))),
        ),
      );
}
