import 'package:flutter/material.dart';
import 'package:glowup/CustomWidgets/Customer/search_bar.dart';
import 'package:glowup/Styles/app_font.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(height: 100,),
        Row(
          children: [
            SizedBox(width: 50,),
            Text("Hello, Sara", style: AppFonts.black32,),
          ],
        ),
         SizedBox(height: 10,),
        Row(
          children: [
            SizedBox(width: 50,),
            Text("Are you ready for a Glow Up", style: AppFonts.light16,),
          ],
        ),
        SizedBox(height: 32,),
        CustomSearchBar(
  controller: TextEditingController(),
  hintText: "Search salons",
)

      ],),
    );
  }
}