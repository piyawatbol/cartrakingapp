// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_print
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:convert';

import 'package:cartrackingapp/ipconnect.dart';
import 'package:cartrackingapp/screen/forget_screen/reset_pass.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ForgetEmail extends StatefulWidget {
  ForgetEmail({Key? key}) : super(key: key);

  @override
  State<ForgetEmail> createState() => _ForgetEmailState();
}

class _ForgetEmailState extends State<ForgetEmail> {
  TextEditingController email = TextEditingController();
  TextEditingController otp = TextEditingController();
  Future<void> sendemail() async {
    var send = await http.post(
        Uri.parse('$ipconnect/forget_password/forgetbyemail.php'),
        body: {'email': email.text});
    var data = json.decode(send.body);
    print(data);
    if (data == "0") {
      Fluttertoast.showToast(
          msg: "ระบบไม่พบอีเมล์ดังกล่าว",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "ระบบกำลังส่งอีเมล์",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> checkotp() async {
    var send = await http.post(
        Uri.parse('$ipconnect/forget_password/checkotp.php'),
        body: {'email': email.text, 'otp': otp.text});
    var data = json.decode(send.body);
    print(data);
    if (data == "error") {
      Fluttertoast.showToast(
          msg: "รหัสยืนยันตัวตน หรือ อีเมล์ ไม่ถูกต้อง",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return ResetPass(
          user_id: data[0]['user_id'],
        );
      }));
    }
  }

  final inputstyle = InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 35),
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(
        width: 3,
        color: Colors.white,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(
        color: Colors.white,
        width: 3,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(
        color: Colors.white,
        width: 3,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(
        color: Colors.red,
        width: 3,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(
        width: 3,
        color: Colors.red,
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.purple.shade700,
                    Colors.pink.shade200,
                    Colors.yellow.shade200
                  ])),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Text(
                    "ยืนยันตัวตนผ่านอีเมล",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Form(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "อีเมล",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                        ),
                        TextFormField(
                          decoration: inputstyle,
                          controller: email,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              sendemail();
                            },
                            child: Container(
                              width: 110,
                              height: 33,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black38,
                                      blurRadius: 2,
                                      offset: Offset(3, 5), // Shadow position
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.orange.shade400,
                                        Colors.pink.shade400
                                      ])),
                              child: Center(
                                child: Text("ส่ง",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ))),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "รหัสยืนยันตัวตน",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                        ),
                        TextFormField(
                          decoration: inputstyle,
                          controller: otp,
                        ),
                      ],
                    )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      print(otp.text);
                      checkotp();
                      /*Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return ResetPass();
                      }));*/
                    },
                    child: Container(
                      width: 110,
                      height: 33,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 2,
                              offset: Offset(3, 5), // Shadow position
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.orange.shade400,
                                Colors.pink.shade400
                              ])),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, top: 1),
                        child: Text("ตกลง",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 110,
                      height: 33,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 3,
                              offset: Offset(2, 5), // Shadow position
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white,
                                Colors.white60,
                                Colors.black12
                              ])),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 21, top: 5),
                        child: Text("ย้อนกลับ",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
