import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:slack/screens/home_screen.dart';
import 'package:slack/screens/signin_screen.dart';
import 'pages/details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> signInWithGoogle() async {
    //create an instance of the firebase auth and google signin
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    //triger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    //obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    //create a new credentail
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      await googleSignIn
          .signIn(); // exception occurs here as soon as we press back button to dismiss the pop up
      if (await googleSignIn.isSignedIn()) {
        // logged in successfully
      }
    } catch (error) {
//failed to login
      print(error);
    }
    //sign in the user with credential
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 13, 69),
      body: Column(children: [
        const SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Text(
                'HenjoS Helps You Search For Pets, Wherever You Are',
                style: TextStyle(
                    color: Color.fromARGB(255, 141, 128, 149),
                    //color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
        Container(
          child: Lottie.network(
              'https://lottie.host/d1c8c684-f6ec-4640-990f-5575746a55d4/FRIJU523d3.json'),
        ),
        SizedBox(height: 40),
        Container(
            child: Padding(
          padding: const EdgeInsets.all(50),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
                child: const Text('Get Started',
                    style: TextStyle(
                        color: Color.fromARGB(255, 119, 4, 112),
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Color.fromARGB(0, 37, 2, 59),
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                            height: 400,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SignInButton(
                                    Buttons.google,
                                    onPressed: () async {
                                      await signInWithGoogle();
                                      if (mounted) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen()));
                                      }
                                    },
                                  ),
                                  Divider(),
                                  SignInButton(
                                    Buttons.email,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignInScreen()));
                                    },
                                  ),
                                  Divider(),
                                  SignInButton(
                                    Buttons.facebookNew,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignInScreen()));
                                    },
                                  ),
                                  Divider(),
                                  SignInButton(
                                    Buttons.gitHub,
                                    text: "Sign up with GitHub",
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Details_page()));
                                    },
                                    // Flutter Sign-in buttons - FlutterAnt
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SignInButton(
                                        Buttons.linkedIn,
                                        mini: true,
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Details_page()));
                                        },
                                      ),
                                      SizedBox(width: 15),
                                      SignInButton(
                                        Buttons.tumblr,
                                        mini: true,
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Details_page()));
                                        },
                                      ),
                                      SizedBox(width: 15),
                                      SignInButton(
                                        Buttons.facebook,
                                        mini: true,
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Details_page()));
                                        },
                                      ),
                                      SizedBox(width: 15),
                                      SignInButtonBuilder(
                                        icon: Icons.email,
                                        text: "Ignored for mini button",
                                        mini: true,
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Details_page()));
                                        },
                                        backgroundColor: Colors.cyan,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      });
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => Details_page()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                )),
          ),
        ))
      ]),
    );
  }
}
