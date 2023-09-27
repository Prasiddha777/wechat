import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wechat/main.dart';
import 'package:wechat/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        setState(() {
          _isAnimate = true;
        });
      },
    );
  }

  _handleGoogleBtnClick() {
    signInWithGoogle().then((value) {
      // log('User: ${value.user}' as );
      print('User: ${value.user}');
      print('User: ${value.additionalUserInfo}');

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          AnimatedPositioned(
            top: mq.height * .15,
            left: _isAnimate ? mq.width * .25 : mq.width * .5,
            width: mq.width * .5,
            duration: const Duration(seconds: 1),
            child: const Icon(
              CupertinoIcons.chat_bubble_2,
              color: Colors.indigo,
              size: 150,
            ),
          ),
          Positioned(
            bottom: mq.height * .15,
            left: mq.width * .05,
            width: mq.width * .9,
            height: mq.height * .06,
            child: ElevatedButton.icon(
              onPressed: () {
                _handleGoogleBtnClick();
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const HomeScreen(),
                //     ));
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 1,
              ),
              icon: const Icon(Icons.g_mobiledata),
              label: const Text(
                'Signin with Google',
              ),
            ),
          )
        ],
      )),
      // body: SafeArea(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Icon(
      //         CupertinoIcons.chat_bubble_2_fill,
      //         color: Colors.indigo,
      //         size: 200,
      //       ),
      //       SizedBox(
      //         width: mq.width * 0.9,
      //         child: ElevatedButton(
      //           onPressed: () {},
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Icon(Icons.g_mobiledata_rounded),
      //               const Text('Signin with Google'),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
