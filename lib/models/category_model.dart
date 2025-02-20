// model này để giao tiếp với UI một cách độc lập so với phần realm model
// khi convert sang một thư viện khác như hive thì chỉ cần thay đổi ở phần entities
// không cần thay đổi ở phần UI
class CategoryModel {
  String id;
  String name;
  int? iconCodePoint;
  String? backgroundColorHex;
  String? iconColorHex;

  CategoryModel({
    required this.id,
    required this.name,
    this.iconCodePoint,
    this.backgroundColorHex,
    this.iconColorHex,
  });
}
