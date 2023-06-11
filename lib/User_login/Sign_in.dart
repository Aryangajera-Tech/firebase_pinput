import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_pinput/User_login/Signup_page.dart';
import 'package:firebase_pinput/User_login/forget_pass.dart';
import 'package:firebase_pinput/User_login/helper_function.dart';
import 'package:firebase_pinput/User_login/phone/user_phone.dart';
import 'package:firebase_pinput/const/snackbar.dart';
import 'package:firebase_pinput/home_page/home.dart';
import 'package:firebase_pinput/home_page/resent_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_service.dart';

User? user = FirebaseAuth.instance.currentUser;

class sign_in extends StatefulWidget {
  const sign_in({Key? key}) : super(key: key);

  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _isObscure = true;
  AuthService authService = AuthService();

  Future<User?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
        print("Google SignIn ~~>> ${user.toString()}");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Home()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          print(e.code);
        } else if (e.code == 'invalid-credential') {
          print(e.code);
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      print("Google SignIn 123~~>> ${user.toString()}");
    }
    return user;
  }

  login() async {
    if (formKey.currentState!.validate()) {
      await authService
          .loginWithUserNameandPassword(email, password)
          .then((value) async {
        if (value == true) {
          // saving the values to our shared preferences
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Home()));
        } else {
          showSnackbar(context, Colors.red, value);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: formKey ,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 40,
            ),
            Image.asset(
              'assets/image/login.png',
              width: 150,
              height: 150,
            ),
            SizedBox(
              height: 25,
            ),
            Text('Log In',
                style: GoogleFonts.playfairDisplay(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
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
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                  hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                  suffixIcon: Icon(
                    Icons.mail,
                    color: Colors.black,
                  )),
            ),
            SizedBox(
              height: 7,
            ),
            Row(
              children: [
                Text(
                  'Password',
                  style: GoogleFonts.nunito(
                      fontSize: 20, fontWeight: FontWeight.w900),
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
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                  hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                  // labelText: 'Password',
                  suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      })),

            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Text(
                      'Forgeot Password?',
                      style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey.shade500),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Forget_Pass(),
                          ));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                login();
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 80,
                alignment: Alignment.center,
                child: Text(
                  'Log In',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black87),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(00, 15, 00, 00),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ? ",
                      style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey.shade500)),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => signup_page(),
                            ));
                      },
                      child: const Text(
                        'Sign-Up',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(children: <Widget>[
                const Expanded(
                    child: Divider(
                  thickness: 2,
                )),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child:
                      Text("Or login with", style: const TextStyle(fontSize: 15)),
                ),
                Expanded(
                    child: Divider(
                  thickness: 2,
                )),
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.black87,
                    child: InkWell(
                      onTap: () {
                        signInWithGoogle();
                      },
                      child: Icon(
                        Icons.email_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                    )),
                const SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.black87,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Phone()));
                      },
                      child: Icon(
                        Icons.phone,
                        size: 40,
                        color: Colors.white,
                      ),
                    ))
              ],
            )
          ]),
        ),
      ),
    ));
  }
}
