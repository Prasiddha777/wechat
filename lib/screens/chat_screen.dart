import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat/api/api.dart';
import 'package:wechat/main.dart';
import 'package:wechat/models/chat_user.dart';
import 'package:wechat/models/message.dart';
import 'package:wechat/widgets/message_card.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.user});
  final ChatUser user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //for storing messages;
  List<Message> _list = [];

  final TextEditingController _textController = TextEditingController();

  final textController = TextEditingController;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          //
          title: _appBar(),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 6,
              child: StreamBuilder(
                stream: APIs.getAllMessages(widget.user),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const SizedBox();
                    // return const Center(
                    //   child: CircularProgressIndicator(),
                    // );
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;
                      for (var i in data!) {
                        log(jsonEncode(i.data()));
                      }

                      // final data = snapshot.data?.docs;
                      //kati data ayecha check garna lai
                      // for (var element in data!) {
                      //   log(jsonEncode(element.data()));
                      //   list.add(element.data()['name']);
                      // }
                      _list = data.map((e) => Message.fromJson(e.data())).toList();

                      if (_list.isNotEmpty) {
                        return ListView.builder(
                          itemCount: _list.length,
                          padding: EdgeInsets.only(
                            top: mq.height * .01,
                          ),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return MessageCard(
                              message: _list[index],
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text(
                            'Say Hi!',
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
            // ListView(child: _chatInput()),
            Expanded(
              flex: 1,
              child: ListView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  _chatInput(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //for app bar
  Widget _appBar() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CachedNetworkImage(
            width: mq.height * .045,
            height: mq.height * .045,
            imageUrl: widget.user.image,
            // placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => const CircleAvatar(
              child: Icon(CupertinoIcons.person),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.user.name,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            const Text(
              'Last seen not available',
              style: TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            )
          ],
        ),
      ],
    );
  }

  // for chat input field
  Widget _chatInput() {
    return Row(
      children: [
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.emoji_emotions,
                    color: Colors.purple,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Type Something...',
                      helperStyle: TextStyle(
                        color: Colors.purpleAccent,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                //image from gallery
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.image,
                    color: Colors.purple,
                  ),
                ),
                //image from camera
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.camera,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ),
        ),
        //
        MaterialButton(
          onPressed: () {
            if (_textController.text.isNotEmpty) {
              APIs.sendMessages(widget.user, _textController.text.toString());
              _textController.text = '';
            }
          },
          // padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
          shape: const CircleBorder(),
          color: Colors.green,
          child: const Icon(
            Icons.send,
            color: Colors.white,
            size: 25,
          ),
        ),
      ],
    );
  }
}
