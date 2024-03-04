import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:my_family/models/models.dart';
import 'package:path_provider/path_provider.dart';

class FamilyDatabase extends ChangeNotifier {
  static late Isar isar;

  // INITIALIZE DATABASE
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [UserSchema],
      directory: dir.path,
    );
  }

  // list of child
  final List<User> familyChild = [];

  // CREATE - ADD A CHILD
  Future<void> addNewChild(User user) async {
    await isar.writeTxn(() => isar.users.put(user));

    await fetchChild();
  }

  // READ - SEE MY CHILD
  Future<void> fetchChild() async {
    List<User> fetchedChild = await isar.users.where().findAll();
    familyChild.clear();
    familyChild.addAll(fetchedChild);
    notifyListeners();
  }

  // DELETE - DELETE A CHILD
  Future<void> deleteChild(int id) async {
    await isar.writeTxn(() => isar.users.delete(id));
    await fetchChild();
  }
}
