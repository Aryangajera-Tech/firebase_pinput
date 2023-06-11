import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pinput/User_login/phone/toast.dart';
import 'package:firebase_pinput/User_login/phone/user_phone_otp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Phone extends StatefulWidget {
  const Phone({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
 // String number = "";
  TextEditingController countrycode = TextEditingController();
  var phone = '';

  @override
  void initState() {
    countrycode.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'assets/image/phone.png',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 25,
              ),
              Text('Phone Verification',
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
              Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            phone = value;
                          });
                        },
                        controller: countrycode,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    Text(
                      '',
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        phone = value;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Phone"),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  // style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.purpleAccent)),
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '${countrycode.text + phone}',
                        verificationCompleted:(PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {
                          showToast('Please enter the proper number.');
                    },
                        codeSent: (String verificationId, int? resendToken) {
                          Phone.verify = verificationId;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Phone_Otp(),));
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {});

                  },
                  child: Text('Send the code'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black87,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
