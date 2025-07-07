import 'package:flutter/material.dart';

class FilterPopup extends StatelessWidget {
  const FilterPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text("Filter Options"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text("Add checkboxes, dropdowns, or categories here."),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Close"),
        ),
      ],
    );
  }
}
