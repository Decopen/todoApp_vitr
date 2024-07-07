import 'package:flutter/material.dart';

class PageAdd extends StatelessWidget {
  PageAdd({
    super.key,
    required this.controller,
    required this.onAdd,
    required this.onAnnuler,
    required this.nomBtn,
  });
  dynamic controller;
  Function()? onAdd;
  Function()? onAnnuler;
  String nomBtn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Ajouter vos tâches"),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: controller,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: onAnnuler,
                child: const Text("annuler"),
              ),
              ElevatedButton(
                onPressed: onAdd,
                child: Text(nomBtn),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
