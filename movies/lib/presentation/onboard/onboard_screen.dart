import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/core/constant/color.dart';
import 'package:movies/core/constant/color.dart';
import 'package:movies/core/constant/string.dart';
import 'package:movies/core/widget/app_button.dart';
import 'package:movies/presentation/auth/screen/login_screen.dart';
import 'package:movies/presentation/home/home_screen.dart';

class OnboardScreen extends StatelessWidget {
  static const String routeName = 'onboard';

  const OnboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: height,
            width: width,
            child: Image.asset(
              AppString.pathOnboardImage,
              fit: BoxFit.fitWidth,
            ),
          ),
          _onboardBody(
            height,
            width,
            context,
          ),
        ],
      ),
    );
  }

  Widget _onboardBody(double height, double width, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          AppString.textWelcome,
          style: TextStyle(
              color: AppColors.white,
              fontSize: 26,
              fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: height * .02,
        ),
        const Text(
          AppString.textOnboardSub,
          style: TextStyle(color: AppColors.white),
        ),
        SizedBox(
          height: height * .02,
        ),
        AppButton(
          margin: const EdgeInsets.all(20),
          onTap: () {
            context.pushNamed(HomeScreen.routeName);
          },
          label: AppString.textGetStarted,
        ),
        SizedBox(
          height: height * .02,
        ),
      ],
    );
  }
}
