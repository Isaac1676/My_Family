import 'package:isar/isar.dart';

part 'models.g.dart';

@Collection()
class User {
  Id id = Isar.autoIncrement;
  String name;
  String age;
  String image;

  User({required this.name, required this.age, required this.image});
}
