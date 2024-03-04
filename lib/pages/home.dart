import 'package:flutter/material.dart';
import 'package:my_family/components/list_tile.dart';
import 'package:my_family/database/family_database.dart';
import 'package:my_family/models/models.dart';
import 'package:my_family/pages/child_sexe.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void openDeleteBox(User child) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Child"),
        actions: [
          _cancelButton(),
          _deleteButton(child.id),
        ],
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FamilyDatabase>().fetchChild();
    });
  }

  @override
  Widget build(BuildContext context) {
    final childDatabase = context.watch<FamilyDatabase>();
    final currentChildren = childDatabase.familyChild;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const ChildSexe())));
        },
        backgroundColor: Colors.blue, // Set the background color to blue
        foregroundColor: Colors.white, // Set the icon color to white
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "My Family",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 30,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 30),
            const Row(
              children: [
                SizedBox(width: 20),
                Icon(
                  Icons.assignment_ind_outlined,
                  size: 36,
                  color: Colors.black,
                ),
                SizedBox(width: 15),
                Text(
                  "My children",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Rubik',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: currentChildren.length,
                itemBuilder: (context, index) {
                  final child = currentChildren[index];
                  return MyList(
                    image: child.image,
                    title: child.name,
                    subtitle: child.age,
                    onDelPressed: (p0) => openDeleteBox(child),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _deleteButton(int id) {
    return MaterialButton(
      onPressed: () async {
        Navigator.pop(context);
        try {
          await context.read<FamilyDatabase>().deleteChild(id);
        } catch (error) {
          print(error);
          // Handle the error appropriately (e.g., show a snackbar)
        }
      },
      child: const Text("Delete"),
    );
  }

  Widget _cancelButton() {
    return MaterialButton(
      onPressed: () => Navigator.pop(context),
      child: const Text("Cancel"),
    );
  }
}
