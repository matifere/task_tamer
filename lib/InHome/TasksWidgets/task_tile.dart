import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  TaskTile({super.key});
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Adjust the radius
          side: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 2,
          ),
        ),
      ),
      iconAlignment: IconAlignment.start,
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Center(
            child: Column(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Task Settings',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text("Edit or delete this task"),
                FilledButton.icon(
                  onPressed: () {},
                  label: Text("Edit"),
                  icon: Icon(Icons.edit),
                ),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: () {},
                  label: Text("Delete"),
                  icon: Icon(Icons.delete),
                ),
                TextButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  label: Text("Cancel"),
                  icon: Icon(Icons.cancel),
                ),
              ],
            ),
          ),
        );
      },
      onPressed: () {
        // ignore: avoid_print
        print("iniciar tarea");
      },
      label: Align(
        alignment: AlignmentGeometry.centerStart,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Un Titulo"), Text("ppm: 10")],
        ),
      ),
      icon: Icon(Icons.fire_hydrant_alt_outlined),
    );
  }
}
