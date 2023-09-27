import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('We Chat'),
        centerTitle: false,
        leading: const Icon(
          CupertinoIcons.chat_bubble_2_fill,
          size: 30,
          color: Colors.deepPurple,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_rounded,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert_outlined,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          CupertinoIcons.add_circled_solid,
          color: Colors.white,
        ),
      ),
    );
  }
}
