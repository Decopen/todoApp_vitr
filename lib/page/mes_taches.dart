import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:vite/data/database.dart';
import 'package:vite/page/page_add.dart';
import 'package:vite/widgets/tache_apparence.dart';

class MesTaches extends StatefulWidget {
  const MesTaches({super.key});

  @override
  State<MesTaches> createState() => _MesTachesState();
}

class _MesTachesState extends State<MesTaches> {
  ToDoDatabase db = ToDoDatabase();
  // reference the hive box
  final _myBox = Hive.box("My box");

  @override
  void initState() {
    // si c'est la première fois que l'application est ouverte ...
    if (_myBox.get("TODOLIST") == null) {
      db.CreateInitialData();
    } else {
      // il exiest deja des taches
      db.LoadData();
    }

    super.initState();
  }

  void onChanged(bool? value, int index) {
    setState(() {
      // Taches[index][1] = !Taches[index][1];
      db.Taches[index][1] = !db.Taches[index][1];
    });
    db.updateDatabase();
  }

  void onDelete(BuildContext context, int index) {
    setState(() {
      db.Taches.removeAt(index);
    });
    _controller.text = "";
    db.updateDatabase();
  }

  void onAdd() {
    if (_controller.text.trim().isEmpty) {
      return;
    }
    setState(() {
      db.Taches.add([_controller.text, false]);
    });
    Navigator.pop(context);
    _controller.text = "";
    db.updateDatabase();
  }

  final _controller = TextEditingController();
  void newBoiteAdd() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageAdd(
          controller: _controller,
          onAdd: onAdd,
          onAnnuler: onAnnuler,
          nomBtn: "Ajouter",
        ),
      ),
    );
    db.updateDatabase();
  }

  void onModifier(int index) {
    if (_controller.text == "") {
      return;
    }
    setState(() {
      db.Taches[index][0] = _controller.text;
    });
    Navigator.pop(context);
    _controller.text = "";
    db.updateDatabase();
  }

  void newBoiteModifi(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageAdd(
          controller: _controller,
          onAdd: () => onModifier(index),
          onAnnuler: onAnnuler,
          nomBtn: "Modifier",
        ),
      ),
    );
  }

  void pageModifier(int index) {
    _controller.text = db.Taches[index][0];
    setState(() {
      newBoiteModifi(index);
    });
    db.updateDatabase();
  }

  void onAnnuler() {
    Navigator.pop(context);
    _controller.text = "";
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Toutes mes taches"),
      ),
      body: ListView.builder(
        itemCount: db.Taches.length,
        itemBuilder: (context, index) => GestureDetector(
          onLongPress: () => pageModifier(index),
          child: TacheApparence(
            fait: db.Taches[index][1],
            titre: db.Taches[index][0],
            onChanged: (value) => onChanged(value, index),
            onDelete: (context) => onDelete(context, index),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: newBoiteAdd,
        backgroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
