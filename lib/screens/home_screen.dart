import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wechat/api/api.dart';
import 'package:wechat/main.dart';
import 'package:wechat/models/chat_user.dart';
import 'package:wechat/screens/profile_screen.dart';
import 'package:wechat/widgets/chat_user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];
  final List<ChatUser> _searchList = [];
  bool isSearching = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    APIs.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (isSearching) {
            setState(() {
              isSearching = !isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: isSearching
                ? TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name,Email......',
                    ),
                    autofocus: true,
                    style: const TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                    onChanged: (value) {
                      //search logic
                      _searchList.clear();
                      for (var i in list) {
                        if (i.name.toLowerCase().contains(value.toLowerCase()) ||
                            i.email.toLowerCase().contains(value.toLowerCase())) {
                          _searchList.add(i);
                        }
                        setState(() {
                          _searchList;
                        });
                      }
                    },
                  )
                : const Text('We Chat'),
            centerTitle: false,
            leading: const Icon(
              CupertinoIcons.chat_bubble_2_fill,
              size: 30,
              color: Colors.deepPurple,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isSearching = !isSearching;
                  });
                },
                icon: Icon(
                  isSearching ? CupertinoIcons.clear_circled_solid : Icons.search_rounded,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          user: APIs.me,
                        ),
                      ));
                },
                icon: const Icon(
                  Icons.more_vert_outlined,
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
            },
            child: const Icon(
              CupertinoIcons.add_circled_solid,
              color: Colors.white,
            ),
          ),
          //
          body: StreamBuilder(
            stream: APIs.getAllUsers(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                case ConnectionState.done:
                  final data = snapshot.data?.docs;
                  //kati data ayecha check garna lai
                  // for (var element in data!) {
                  //   log(jsonEncode(element.data()));
                  //   list.add(element.data()['name']);
                  // }
                  list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

                  if (list.isNotEmpty) {
                    return ListView.builder(
                      itemCount: isSearching ? _searchList.length : list.length,
                      padding: EdgeInsets.only(
                        top: mq.height * .01,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ChatUserCard(
                          user: isSearching ? _searchList[index] : list[index],
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'No Connection Found!',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    );
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
