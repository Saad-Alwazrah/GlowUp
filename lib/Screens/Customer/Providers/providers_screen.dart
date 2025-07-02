import 'package:flutter/material.dart';
import 'package:glowup/CustomWidgets/Customer/search_bar.dart';

class ProvidersScreen extends StatelessWidget {
  const ProvidersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 96),
          Row(
            children: [
              SizedBox(width: 32),
              CustomSearchBar(
                controller: TextEditingController(),
                hintText: "Search providers",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
