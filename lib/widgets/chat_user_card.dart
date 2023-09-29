import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat/models/chat_user.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key, required this.user});
  final ChatUser user;

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.user.image.toString()),
            // child: Icon(CupertinoIcons.person),
          ),
          title: Text(widget.user.name.toString()),
          subtitle: Text(
            widget.user.about.toString(),
            maxLines: 1,
          ),
          trailing: const Text(
            '12:00 PM',
            style: TextStyle(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
