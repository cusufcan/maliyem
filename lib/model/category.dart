import 'index.dart';

class Category extends Name {
  Category({
    required String name,
  }) : super(name: name);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] as String,
    );
  }

  @override
  String toString() => "Category(name: $name)";
}
