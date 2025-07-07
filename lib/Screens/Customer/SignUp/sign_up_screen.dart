import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/shared/custom_auth_container.dart';
import 'package:glowup/CustomWidgets/shared/custom_background_container.dart';
import 'package:glowup/CustomWidgets/Customer/sign_up_widgets/sign_up_screens/first_page_view.dart';
import 'package:glowup/CustomWidgets/Customer/sign_up_widgets/sign_up_screens/second_page_view.dart';
import 'package:glowup/CustomWidgets/Customer/sign_up_widgets/sign_up_screens/third_page_view.dart';
import 'package:glowup/CustomWidgets/shared/ontap_text.dart';
import 'package:glowup/Screens/Customer/SignUp/bloc/sign_up_bloc.dart';
import 'package:glowup/Screens/Shared/Login/login_screen.dart';
import 'package:glowup/Styles/app_font.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<SignUpBloc>();
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 64.h),

                Image.asset(
                  "assets/images/logo1.png",
                  height: 200.h,
                  width: 200.w,
                  fit: BoxFit.cover,
                ),
                Spacer(),
                BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    return BackgroundContainer(
                      heightSize: 0.7,
                      childWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 24),
                          Text(
                            bloc.titleText[bloc.currentPage],
                            style: AppFonts.semiBold24,
                          ),
                          SizedBox(height: 24),
                          SmoothPageIndicator(
                            controller: bloc.pageController,
                            count: 3,
                            effect: ExpandingDotsEffect(
                              radius: 16,
                              dotWidth: 58,
                              dotHeight: 8,
                              dotColor: Colors.grey,
                              activeDotColor: Colors.black,
                            ),
                          ),
                          SizedBox(height: 24),
                          Expanded(
                            child: PageView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: bloc.pageController,
                              children: [
                                FirstPageView(
                                  formKey: bloc.signUpformKey,
                                  nameController: bloc.nameController,
                                  nameValidation: (value) =>
                                      bloc.userNameValidation(text: value),
                                  emailController: bloc.emailController,
                                  emailValidation: (value) =>
                                      bloc.emailValidation(text: value),
                                  passwordController: bloc.passwordController,
                                  passwordValidation: (value) =>
                                      bloc.passwordValidation(text: value),
                                  confirmPasswordController:
                                      bloc.confirmPasswordController,
                                  confirmPasswordValidation: (value) => bloc
                                      .confrimPasswordValidation(text: value),
                                  pressedMethod: () =>
                                      bloc.add(CreateAccountEvent()),
                                ),
                                SecondPageView(
                                  formKey: bloc.locationFormKey,
                                  controller: bloc.addressController,
                                  pressedMethod: () =>
                                      bloc.add(SendConfermationEvent()),
                                  addressValidation: (value) =>
                                      bloc.addressValidation(text: value),
                                ),
                                ThirdPageView(),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),

                          OntapText(
                            text: "Already have an account?  Login",
                            pressedMethod: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 24),
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
