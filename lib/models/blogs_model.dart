class BlogsModel {
  String? id;
  String? title;
  String? body;
  String? userId;
  String? imageUrl;
  List<String>? tags;
  List<String>? likes;
  int? reactions;
  bool isLiked = false;

  BlogsModel({
    this.id,
    this.title,
    this.body,
    this.userId,
    this.tags,
    this.likes,
    this.reactions,
    this.imageUrl,
    this.isLiked = false,
  });

  BlogsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    userId = json['userId'];
    imageUrl = json['imageUrl'];
    tags = json['tags'];

    if (json['likes'] != null) {
      likes = json['likes'].cast<String>();
    }

    reactions = json['reactions'];
    isLiked = json["isLiked"] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['userId'] = userId;
    data['imageUrl'] = imageUrl;
    data['tags'] = tags;
    data['likes'] = likes;
    data['reactions'] = reactions;
    return data;
  }
}
