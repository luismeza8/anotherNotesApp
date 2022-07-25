class Notes {
  final int? id;
  final String? title;
  final String? description;

  Notes({this.id, required this.title, this.description});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
    };
  }
}
