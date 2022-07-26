class Pizza {
  int id;
  String name;
  String image;
  Pizza({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Pizza.fromMap(Map<String, dynamic> map) {
    return Pizza(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }
}
