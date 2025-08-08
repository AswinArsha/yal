import 'package:flutter/material.dart';

class CompletedTasksContent extends StatelessWidget {
  const CompletedTasksContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'This is Completed Tasks content.',
      style: TextStyle(color: Colors.white),
    ));
  }
}
