import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wechat/helper/dialogs.dart';
import 'package:wechat/main.dart';
import 'package:wechat/models/chat_user.dart';
import 'package:wechat/screens/auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.user});

  final ChatUser user;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile Screen'),
          centerTitle: true,
        ),
        //
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.redAccent,
          onPressed: () async {
            Dialogs.showProgressBar(context);

            await FirebaseAuth.instance.signOut().then((value) async {
              await GoogleSignIn().signOut().then((value) {
                Navigator.pop(context);
                //
                Navigator.pop(context);
                //
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
              });
            });
          },
          icon: const Icon(
            CupertinoIcons.add_circled_solid,
            color: Colors.white,
          ),
          label: const Text(
            'Logout',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          // child: const Icon(
          //   CupertinoIcons.add_circled_solid,
          //   color: Colors.white,
          // ),
        ),

        //
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mq.width * .05,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: mq.width,
                  height: mq.height * .03,
                ),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(mq.height * .1),
                      child: CachedNetworkImage(
                        width: mq.height * .2,
                        height: mq.height * .2,
                        fit: BoxFit.fill,
                        imageUrl: widget.user.image,
                        // placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: MaterialButton(
                        onPressed: () {},
                        elevation: 1,
                        shape: const CircleBorder(),
                        color: Colors.white,
                        child: const Icon(
                          Icons.edit,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: mq.width,
                  height: mq.height * .03,
                ),
                Text(
                  widget.user.email.toString(),
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: mq.width,
                  height: mq.height * .03,
                ),
                TextFormField(
                  initialValue: widget.user.name.toString(),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(CupertinoIcons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'eg Prasiddha Khadka',
                    label: const Text('Name'),
                  ),
                ),
                SizedBox(
                  width: mq.width,
                  height: mq.height * .03,
                ),
                TextFormField(
                  initialValue: widget.user.about.toString(),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(CupertinoIcons.info_circle),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'eg Felling Happy',
                    label: const Text('About'),
                  ),
                ),
                SizedBox(
                  width: mq.width,
                  height: mq.height * .03,
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: Colors,
                    shape: const StadiumBorder(),
                    maximumSize: Size(mq.width * .7, mq.height * .06),
                  ),
                  icon: const Icon(Icons.update),
                  label: const Text(
                    'UPDATE',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
