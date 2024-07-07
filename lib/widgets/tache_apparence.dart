import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TacheApparence extends StatelessWidget {
  TacheApparence({
    super.key,
    required this.fait,
    required this.titre,
    required this.onChanged,
    required this.onDelete,
  });
  bool fait;
  String titre;
  Function(bool?)? onChanged;
  void Function(BuildContext)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onDelete,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade200,
              borderRadius: BorderRadius.circular(5),
            )
          ],
        ),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.deepOrange[50],
          ),
          child: Row(
            children: [
              Checkbox(
                value: fait,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              Expanded(
                child: Text(
                  titre,
                  style: TextStyle(
                    decoration:
                        fait ? TextDecoration.lineThrough : TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}