import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat/api/api.dart';
import 'package:wechat/helper/my_date_util.dart';
import 'package:wechat/main.dart';
import 'package:wechat/models/message.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message});
  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.auth.currentUser!.uid == widget.message.fromId
        ? _greenMessages()
        : _blueMessages();
  }

  //sender or another user messages
  Widget _blueMessages() {
    //update last read message if sender and receiver are different
    if (widget.message.read.isNotEmpty) {
      APIs.updateMessageReadStatus(widget.message);
      log('updated');
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(
              mq.width * .04,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: mq.width * .04,
              vertical: mq.height * .01,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              border: Border.all(color: Colors.lightBlue),
            ),
            child: Text(
              widget.message.msg,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        //
        Padding(
          padding: EdgeInsets.only(
            right: mq.width * .04,
          ),
          child: Text(
            MyDateUtil.getFormattedTime(context: context, time: widget.message.sent),
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ),

        //
        // SizedBox(
        //   width: mq.width * .04,
        // ),
      ],
    );
  }

  //our or user messages
  Widget _greenMessages() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        Row(
          children: [
            SizedBox(
              width: mq.width * .04,
            ),
            if (widget.message.read.isNotEmpty)
              const Icon(
                Icons.done_all,
                color: Colors.blue,
                size: 20,
              ),
            const SizedBox(
              width: 2,
            ),
            Text(
              MyDateUtil.getFormattedTime(context: context, time: widget.message.sent),
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(
              mq.width * .04,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: mq.width * .04,
              vertical: mq.height * .01,
            ),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              border: Border.all(color: Colors.lightGreen),
            ),
            child: Text(
              widget.message.msg,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
        ),

        //
        // SizedBox(
        //   width: mq.width * .04,
        // ),
      ],
    );
  }
}
