class ChatUser {
  ChatUser({
    required this.isOnline,
    required this.id,
    required this.pushToken,
    required this.imageUrl,
    required this.email,
    required this.username,
    required this.lastActive,
  });
  late bool isOnline;
  late String id;
  late String pushToken;
  late String imageUrl;
  late String email;
  late String username;
  late String lastActive;

  ChatUser.fromJson(Map<String, dynamic> json) {
    isOnline = json['is_online'] ?? '';
    id = json['id'] ?? '';
    pushToken = json['push_token'] ?? '';
    imageUrl = json['image_url'] ?? '';
    email = json['email'] ?? '';
    username = json['username'] ?? '';
    lastActive = json['last_active'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['is_online'] = isOnline;
    data['id'] = id;
    data['push_token'] = pushToken;
    data['image_url'] = imageUrl;
    data['email'] = email;
    data['username'] = username;
    data['last_active'] = lastActive;
    return data;
  }
}
