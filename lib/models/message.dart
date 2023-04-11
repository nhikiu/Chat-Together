class Message {
  Message({
    required this.fromid,
    required this.toid,
    required this.userimage,
    required this.text,
    required this.createAt,
    required this.type,
    required this.username,
  });
  late final String fromid;
  late final String toid;
  late final String userimage;
  late final String text;
  late final String createAt;
  late final Type type;
  late final String username;

  Message.fromJson(Map<String, dynamic> json) {
    fromid = json['fromid'].toString();
    toid = json['toid'].toString();
    userimage = json['userimage'].toString();
    text = json['text'].toString();
    createAt = json['createAt'].toString();
    type = json['type'].toString() == Type.text.name ? Type.text : Type.image;
    username = json['username'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fromid'] = fromid;
    _data['toid'] = toid;
    _data['userimage'] = userimage;
    _data['text'] = text;
    _data['createAt'] = createAt;
    _data['type'] = type.name;
    _data['username'] = username;
    return _data;
  }
}

enum Type { text, image }
