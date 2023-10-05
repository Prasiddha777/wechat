import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wechat/models/chat_user.dart';
import 'package:wechat/models/message.dart';

class APIs {
  //for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //get for user
  // static get user => auth.currentUser!;

  //for accessing cloud firestore database
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //for checking if the user exist or not
  static Future<bool> userExist() async {
    return (await fireStore.collection('users').doc(auth.currentUser!.uid).get()).exists;
  }

  //for storing self info
  static late ChatUser me;

  //for getting current user info
  static Future<void> getSelfInfo() async {
    await fireStore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) async {
      if (value.exists) {
        me = ChatUser.fromJson(value.data()!);
      } else {
        await createUser().then((value) {
          getSelfInfo();
        });
      }
    });
  }

  //for creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
        image: auth.currentUser!.photoURL.toString(),
        name: auth.currentUser!.displayName.toString(),
        about: 'Hey, I am a new user',
        createdAt: time,
        isOnline: false,
        lastActive: time,
        id: auth.currentUser!.uid,
        pushToken: '',
        email: auth.currentUser!.email.toString());
    return await fireStore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(chatUser.toJson());
  }

  //get users
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return fireStore
        .collection('users')
        .where('id', isNotEqualTo: auth.currentUser!.uid)
        .snapshots();
  }

  //update user
  static Future<void> updateUserInfo() async {
    await fireStore.collection('users').doc(auth.currentUser!.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }

  /************ CHAT SCREEN REALTED APIs *****************/

  // conversation id
  static String getConversationId(String id) {
    return auth.currentUser!.uid.hashCode <= id.hashCode
        ? '${auth.currentUser!.uid}_$id'
        : '${id}_${auth.currentUser!.uid}';
  }

  //for getting messages
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(ChatUser user) {
    return fireStore
        .collection('chats/${getConversationId(user.id)}/messages')
        .snapshots();
  }

  //foe sending messages
  static Future<void> sendMessages(ChatUser chatUser, String msg) async {
    //message sending time also used as id
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Message message = Message(
      msg: msg,
      toId: chatUser.id,
      read: '',
      type: Type.text,
      fromId: auth.currentUser!.uid,
      sent: time,
    );
    final ref = fireStore.collection('chats/${getConversationId(chatUser.id)}/messages');
    await ref.doc(time).set(message.toJson());
  }

  //
  static Future<void> updateMessageReadStatus(Message message) async {
    fireStore
        .collection('chats/${getConversationId(message.fromId)}/messages')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }
}
