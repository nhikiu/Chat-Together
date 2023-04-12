class ChatUser {
  ChatUser({
    required this.id,
    required this.pushToken,
    required this.imageUrl,
    required this.email,
    required this.username,
  });
  late String id;
  late String pushToken;
  late String imageUrl;
  late String email;
  late String username;

  ChatUser.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    pushToken = json['push_token'] ?? '';
    imageUrl = json['image_url'] ?? '';
    email = json['email'] ?? '';
    username = json['username'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['push_token'] = pushToken;
    data['image_url'] = imageUrl;
    data['email'] = email;
    data['username'] = username;
    return data;
  }
}
