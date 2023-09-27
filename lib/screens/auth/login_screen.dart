import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
            top: mq.height * .15,
            left: mq.width * .25,
            width: mq.width * .5,
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
              onPressed: () {},
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
