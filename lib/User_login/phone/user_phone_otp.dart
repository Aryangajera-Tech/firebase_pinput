import 'package:firebase_pinput/User_login/phone/user_phone.dart';
import 'package:firebase_pinput/home_page/home.dart';
import 'package:firebase_pinput/home_page/resent_home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class Phone_Otp extends StatefulWidget {
  const Phone_Otp({Key? key}) : super(key: key);

  @override
  State<Phone_Otp> createState() => _Phone_OtpState();
}

class _Phone_OtpState extends State<Phone_Otp> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var code = "";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          alignment: Alignment.center,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios_rounded,size: 30,)),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/image/otp.png',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 25,
              ),
              Text('Sign Up',
                  style: GoogleFonts.playfairDisplay(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'We need to register your phone before getting started !',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value) {
                  code = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  //style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.purpleAccent)),
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: Phone.verify, smsCode: code);
                      await auth.signInWithCredential(credential);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                    } catch (e) {
                      print('wrong otp');
                    }
                  },

                  child: Text('Verify phone number'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black87,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Phone(),));
                      },
                      child: Text(
                        'Edit Phone Number ?',
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
