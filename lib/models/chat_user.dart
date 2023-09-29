class ChatUser {
  ChatUser({
    required this.image,
    required this.name,
    required this.about,
    required this.createdAt,
    required this.isOnline,
    required this.lastActive,
    required this.id,
    required this.pushToken,
    required this.email,
  });
  late final String image;
  late final String name;
  late final String about;
  late final String createdAt;
  late final bool isOnline;
  late final String lastActive;
  late final String id;
  late final String pushToken;
  late final String email;

  //uta bata ako lai afno maw dekhauna obj banauni

  ChatUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    name = json['name'];
    about = json['about'];
    createdAt = json['created_at'];
    isOnline = json['is_online'];
    lastActive = json['last_active'];
    id = json['id'];
    pushToken = json['push_token'];
    email = json['email'];
  }

//afno object lai server maw pathauna toJson
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image'] = image;
    _data['name'] = name;
    _data['about'] = about;
    _data['created_at'] = createdAt;
    _data['is_online'] = isOnline;
    _data['last_active'] = lastActive;
    _data['id'] = id;
    _data['push_token'] = pushToken;
    _data['email'] = email;
    return _data;
  }
}
