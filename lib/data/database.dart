import 'package:hive/hive.dart';

class ToDoDatabase {
  List Taches = [];
  // reference the box
  final _myBox = Hive.box("My box");

  // on use cette methode si c'est la première fois qu'on ouvre l'application
  void CreateInitialData() {
    Taches = [
      ["Faire un tutoriel", false],
      ["Faire mes exo de maison", false]
    ];
  }

  //load Data from the database
  void LoadData() {
    Taches = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDatabase() {
    _myBox.put("TODOLIST", Taches);
  }
}
