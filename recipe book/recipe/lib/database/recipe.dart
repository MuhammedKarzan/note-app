class Recipe {
  int? id;
  String name, requirements, timeAtt, information, photo;
  DateTime time;

  Recipe({
    this.id,
    required this.name,
    required this.requirements,
    required this.photo,
    required this.timeAtt,
    required this.information,
    required this.time
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'requirements': requirements,
      'photo': photo,
      'timeAtt': timeAtt,
      'information': information,
      'time': time.toString(),
    };
  }
}
