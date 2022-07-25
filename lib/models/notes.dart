class Notes {
  final int? id;
  String? title;
  String? description;

  Notes({this.id, this.title, this.description});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
    };
  }

  // void changeDescription(String? description) {
  //   this.description = description;
  // }

  void changeTitle(String title) {
    this.title = title;
  }
}
