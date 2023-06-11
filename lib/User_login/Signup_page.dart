import 'package:firebase_pinput/User_login/auth_service.dart';
import 'package:firebase_pinput/User_login/helper_function.dart';
import 'package:firebase_pinput/const/snackbar.dart';
import 'package:firebase_pinput/home_page/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class signup_page extends StatefulWidget {
  const signup_page({Key? key}) : super(key: key);

  @override
  State<signup_page> createState() => _signup_pageState();
}

class _signup_pageState extends State<signup_page> {
  final formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  late bool _isloading = false;
  String email = "";
  String password = "";
  String fullName = "";
  AuthService authService = AuthService();

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isloading = true;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Home()));
      });
      await authService
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) async {
        if (value == true) {
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);
        } else {
          showSnackbar(context, Colors.red, value);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isloading
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.black,
              ))
            : SingleChildScrollView(
                child: Center(
                  child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Form(
                        key: formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25),
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
                                height: 10,
                              ),
                              Image.asset(
                                'assets/image/sign up.png',
                                width: 150,
                                height: 150,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Text('Sign Up',
                                  style: GoogleFonts.playfairDisplay(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'We need to register your email before getting started !',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Name',
                                    style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                              TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    fullName = val;
                                  });
                                },
                                validator: (val) {
                                  if (val!.isNotEmpty) {
                                    return null;
                                  } else {
                                    return "Name cannot be empty";
                                  }
                                },
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: ('Your name'),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black87),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Email',
                                    style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                              TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                                validator: (val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val!)
                                      ? null
                                      : "Please enter a valid email";
                                },
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: ('Your email-id'),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black87),
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Password',
                                    style: GoogleFonts.nunito(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                              TextFormField(
                                obscureText: _isObscure,
                                validator: (val) {
                                  if (val!.length < 6) {
                                    return "Password must be at least 6 characters";
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: ('Your password'),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black87),
                                    ),
                                    hintStyle: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                    // labelText: 'Password',
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                          _isObscure
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        })),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 45,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    register();
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(fontSize: 23),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black87,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                            ]),
                      )),
                ),
              ));
  }
}
