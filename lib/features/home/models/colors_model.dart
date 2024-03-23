class ColorsModel {
  ColorsModel({
    required this.id,
    required this.name,
  });

  final int? id;
  final String? name;

  factory ColorsModel.fromJson(Map<String, dynamic> json) {
    return ColorsModel(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
