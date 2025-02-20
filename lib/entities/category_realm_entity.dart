import 'package:realm/realm.dart'; // import realm package

part 'category_realm_entity.realm.dart'; // declare the generated part file.

@RealmModel() // define a data model class named `_CategoryRealmEntity`.
class $CategoryRealmEntity {
  @PrimaryKey()
  late ObjectId id;
  late String name;
  late int? iconCodePoint; // lưu icon trong flutter. Icons
  late String?
      backgroundColorHex; // lưu thành color hex string, vì trong flutter color nó ở dưới dạng 1 class nên k lưu được như thế
  late String? iconColorHex;
}
