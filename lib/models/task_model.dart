class TaskModel {
  String? id;
  String? title;
  String? imageUrl;
  String? fileUrl;
  String? date;
  bool? isDone;
  String? uid;

  TaskModel({
    this.id,
    this.title,
    this.imageUrl,
    this.fileUrl,
    this.date,
    this.isDone,
    this.uid,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        title: json["title"],
        imageUrl: json["imageUrl"],
        fileUrl: json["fileUrl"],
        date: json["date"],
        isDone: json["isDone"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "imageUrl": imageUrl,
        "fileUrl": fileUrl,
        "date": date,
        "isDone": isDone,
        "uid": uid,
      };
}
