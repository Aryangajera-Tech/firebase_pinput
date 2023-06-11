import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pinput/User_login/Sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Forget_Pass extends StatefulWidget {
  const Forget_Pass({Key? key}) : super(key: key);

  @override
  State<Forget_Pass> createState() => _Forget_PassState();
}

class _Forget_PassState extends State<Forget_Pass> {
  TextEditingController forgetpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 30,
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 240,
              child: Image.asset('assets/image/forgeot pass...png',
                  fit: BoxFit.fill),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 260,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 3,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 7, 00, 20),
                        child: Text(
                          'Forgeot password',
                          style: GoogleFonts.playfairDisplay(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 00),
                        child: Text('Email',
                            style: GoogleFonts.nunito(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 00, 30, 30),
                    child: TextFormField(
                      controller: forgetpasswordController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: ('Your Email-id'),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87),
                        ),
                        hintStyle: TextStyle(color: Colors.black87, fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          var forgotEmail =
                              forgetpasswordController.text.trim();
                          try {
                            FirebaseAuth.instance
                                .sendPasswordResetEmail(email: forgotEmail)
                                .then((value) => {print('email sent')});
                          } on FirebaseAuthException catch (e) {
                            print("Error $e");
                          }
                        },
                        child: Text('Forgot Password',
                            style: TextStyle(fontSize: 20)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => sign_in()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Back to login',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ))
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
