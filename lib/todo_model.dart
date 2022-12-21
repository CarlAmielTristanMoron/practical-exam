class TodoModel {

  String? title;

  TodoModel({
    required this.title
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
    title: json['title'],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
  };
}
