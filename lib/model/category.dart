import '../constant/index.dart';
import 'index.dart';

class Category extends Name {
  Category({
    String name = BaseString.general,
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
