import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:glowup/CustomWidgets/shared/custom_auth_container.dart';
import 'package:glowup/CustomWidgets/shared/custom_elevated_button.dart';
import 'package:glowup/CustomWidgets/shared/custom_textfield.dart';
import 'package:glowup/CustomWidgets/shared/onTap_text.dart';
import 'package:glowup/Screens/Shared/Login/bloc/login_bloc.dart';
import 'package:glowup/Styles/app_font.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<LoginBloc>();
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                Image.asset("assets/images/logo1.png"),
                Spacer(),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return BackgroundContainer(
                      heightSize: 0.7,
                      childWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(),
                          Text("Welcome Back", style: AppFonts.semiBold24),
                          SizedBox(),
                          Form(
                            key: bloc.loginFormKey,
                            child: Column(
                              children: [
                                CustomTextfield(
                                  textFieldHint: "Email",
                                  textFieldcontroller: bloc.emailController,
                                  validationMethod: (value) =>
                                      bloc.emailValidation(text: value),
                                ),
                                CustomTextfield(
                                  textFieldHint: "Password",
                                  textFieldcontroller: bloc.passwordController,
                                  validationMethod: (value) =>
                                      bloc.passwordValidation(text: value),
                                ),
                              ],
                            ),
                          ),

                          CustomElevatedButton(
                            text: "Login".tr(),
                            onTap: () {
                              bloc.add(ValidateLogin());
                            },
                          ),

                          // SizedBox(),
                          OntapText(
                            text: "Don't have an account?  SignUp",
                            pressedMethod: () {
                              Navigator.pushNamed(context, '/signup');
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => Sign(),
                              //   ),
                              // );
                            },
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
