import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_family/models/models.dart';

class ChildPage extends StatefulWidget {
  final User child;

  const ChildPage({super.key, required this.child});

  @override
  State<ChildPage> createState() => _ChildPageState();
}

class _ChildPageState extends State<ChildPage> {
  @override
  Widget build(BuildContext context) {
    final child = widget.child;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Child",
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
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.blue, size: 32),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Hero(
              tag: child.id,
              child: SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(
                  child.image,
                  fit: BoxFit.cover
                  ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            child.name,
            style: const TextStyle(
              fontSize: 24,
              fontFamily: "Rubik",
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Âge: ${child.age}",
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "Rubik",
            ),
          )
        ],
      ),
    );
  }
}
