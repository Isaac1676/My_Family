import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const MyTextfield({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        style: const TextStyle(color: Colors.black, fontFamily: "Rubik", fontSize: 25),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 25, color: Colors.grey.shade700),
        ),
      ),
    );
  }
}

String getAgeFromDateString(String dateString) {
  // Convertir la date string en DateTime
  DateTime birthDate = DateFormat('dd/MM/yyyy').parse(dateString);

  // Calculer la différence entre la date de naissance et la date d'aujourd'hui
  Duration difference = DateTime.now().difference(birthDate);

  // Calculer les années
  int years = difference.inDays ~/ 365;

  // Calculer les mois restants
  int months = (difference.inDays - years * 365) ~/ 30;

  // Calculer les semaines restantes
  int weeks = (difference.inDays - years * 365 - months * 30) ~/ 7;

  // Retourner l'âge sous forme de string
  return '$years years, $months months et $weeks weeks';
}

