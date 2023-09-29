import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wechat/models/chat_user.dart';

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
}
