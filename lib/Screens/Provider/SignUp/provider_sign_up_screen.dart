import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowup/CustomWidgets/Provider/sign_up/pageviews/provider_first_pageview_sign_up.dart';
import 'package:glowup/CustomWidgets/Provider/sign_up/pageviews/provider_second_pageview_sign_up.dart';
import 'package:glowup/CustomWidgets/Provider/sign_up/pageviews/provider_third_pageview_sign_up.dart';
import 'package:glowup/CustomWidgets/shared/custom_background_container.dart';
import 'package:glowup/Screens/Provider/SignUp/bloc/provider_sign_up_bloc.dart';
import 'package:glowup/Styles/app_font.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProviderSignUpScreen extends StatelessWidget {
  const ProviderSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProviderSignUpBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<ProviderSignUpBloc>();
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
                BlocBuilder<ProviderSignUpBloc, ProviderSignUpState>(
                  builder: (context, state) {
                    return BackgroundContainer(
                      heightSize: 0.7.h,
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
                                ProviderFirstPageviewSignUp(
                                  formKey: bloc.signUpformKey,
                                  nameController: bloc.nameController,
                                  nameValidation: (value) =>
                                      bloc.userNameValidation(text: value),
                                  phoneController: bloc.phoneController,
                                  phoneValidation: (value) =>
                                      bloc.phoneValidation(text: value),
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
                                      bloc.add(CreateProviderAccountEvent()),
                                ),
                                ProviderSecondPageviewSignUp(
                                  formKey: bloc.locationFormKey,
                                  controller: bloc.addressController,
                                  pressedMethod: () =>
                                      bloc.add(SendConfermationEvent()),
                                  addressValidation: (value) =>
                                      bloc.addressValidation(text: value),
                                ),
                                ProviderThirdPageviewSignUp(),
                              ],
                            ),
                          ),
                          SizedBox(height: 24.h),
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
