import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_family/models/models.dart';
import 'package:my_family/pages/child_page.dart';

class MyList extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final void Function(BuildContext)? onDelPressed;

  const MyList({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onDelPressed,
  });


  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: onDelPressed,
            backgroundColor: Colors.red,
            icon: Icons.delete,
          ),
        ],
      ),
      child: ListTile(
        leading: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
        title: Text(title, style: const TextStyle(fontFamily: "Rubik")),
        subtitle: Text(subtitle, style: const TextStyle(fontFamily: "Rubik")),
        trailing: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChildPage(child: User(name:title, age: subtitle, image: image)))
          ),
          icon: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.black87,
            size: 25,
            ),
        ),
      ),
    );
  }
}
