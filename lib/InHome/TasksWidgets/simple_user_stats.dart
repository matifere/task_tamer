import 'package:flutter/material.dart';

class SimpleUserStats extends StatelessWidget {
  const SimpleUserStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 16,
            children: [
              IconButton(icon: Icon(Icons.person), onPressed: () {}),
              Text(
                "username",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Spacer(),
              Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  Center(
                    child: Text(
                      "1",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
