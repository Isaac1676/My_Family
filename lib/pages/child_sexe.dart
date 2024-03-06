import 'package:flutter/material.dart';
import 'package:my_family/components/textfield.dart';
import 'package:my_family/database/family_database.dart';
import 'package:my_family/models/models.dart';
import 'package:my_family/pages/home.dart';
import 'package:provider/provider.dart';

class ChildSexe extends StatefulWidget {
  const ChildSexe({super.key});

  @override
  State<ChildSexe> createState() => _ChildSexeState();
}

class _ChildSexeState extends State<ChildSexe> {
  bool isBoySelected = false;
  bool isGirlSelected = false;
  late String selectedImage;

  void _handleImageTap(bool isBoy) {
    setState(() {
      if (isBoy) {
        selectedImage = "assets/images/boy.png";
      } else {
        selectedImage = "assets/images/girl.png";
      }
      isBoySelected = isBoy;
      isGirlSelected = !isBoy; // Ensure only one image can be selected
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add a child",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Rubik',
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: const Icon(Icons.cancel, color: Colors.blue, size: 32),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _handleImageTap(true),
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/boy.png",
                      width: 120,
                      height: 120,
                    ),
                    if (isBoySelected)
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 35,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 50),
              GestureDetector(
                onTap: () => _handleImageTap(false),
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/girl.png",
                      width: 120,
                      height: 120,
                    ),
                    if (isGirlSelected)
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 35,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 100),
          IconButton(
            onPressed: () {
              // Navigate to next page based on selected sex (isBoySelected or isGirlSelected)
              if (selectedImage.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => ChildName(image: selectedImage)))
                );
              }
            },
            style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(Colors.blue),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            iconSize: 45,
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class ChildName extends StatefulWidget {
  final String image;
  const ChildName({super.key, required this.image});

  @override
  State<ChildName> createState() => _ChildNameState();
}

class _ChildNameState extends State<ChildName> {
  final nameController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add a child",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Rubik',
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true, // Centre le titre
        leading: Padding(
          // Ajoutez un Padding pour déplacer l'icône vers le bord
          padding: const EdgeInsets.only(
              left: 10.0), // Réglez la marge gauche selon vos besoins
          child: IconButton(
            icon: const Icon(
              Icons.cancel,
              color: Colors.blue,
              size: 32,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80,
            ),
            MyTextfield(controller: nameController, hintText: "Name"),
            const SizedBox(
              height: 80,
            ),
            MyTextfield(controller: dateController, hintText: "DD/MM/YYYY"),
            const SizedBox(
              height: 100,
            ),
            saveButton()
          ],
        ),
      ),
    );
  }

  Widget saveButton() {
    return SizedBox(
      width: 250,
      height: 70,
      child: MaterialButton(
        color: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        textColor: Colors.white,
        onPressed: () async {
          if (nameController.text.isNotEmpty && dateController.text.isNotEmpty) {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const HomePage())));
      
            User newChild = User(
                name: nameController.text,
                age: getAgeFromDateString(dateController.text),
                image: widget.image);
      
            await context.read<FamilyDatabase>().addNewChild(newChild);
      
            nameController.clear();
            dateController.clear();
          }
        },
        child: const Text("Submit", style: TextStyle(fontFamily: "Rubik", fontSize: 17),),
      ),
    );
  }
}
