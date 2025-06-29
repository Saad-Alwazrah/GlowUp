import 'package:flutter/material.dart';
import 'package:glowup/CustomWidgets/Customer/button.dart';
import 'package:glowup/Styles/app_font.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
      child: Column(children: [
       SizedBox(height: 200,),
        Image.asset("lib/assets/images/logo2.png"),
        Text("Beauty at Your Fingertips", style: AppFonts.semiBold24,),
        SizedBox(height: 10,),
        Text("Browse top-rated salons near", style: AppFonts.regular22),
                SizedBox(height: 5,),
        Text("you and find services that fit ", style: AppFonts.regular22),
         SizedBox(height: 5,),
        Text("your style fast and very easy", style: AppFonts.regular22),
        SizedBox(height: 64,),
         CustomButton(
  text: "Login",
  onTap: () {
    Navigator.pushNamed(context, '/nextPage');
  },
),
SizedBox(height: 20,),
  CustomButton(
  text: "Sign in",
  onTap: () {
    Navigator.pushNamed(context, '/nextPage');
  },
  
),
SizedBox(height: 32,),
        Text("Are you a Provider? Register here", style: AppFonts.regular14),

      ],),
    )
    );
  }
}