import 'package:flutter/material.dart';

Widget buildTabButton(BuildContext context,
    {required bool isSelected, required String label}) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        // Handle tab switch logic
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.blueGrey.withValues(alpha: 0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}
