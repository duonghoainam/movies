import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/core/constant/color.dart';
import 'package:movies/core/constant/string.dart';
import 'package:movies/core/widget/app_button.dart';
import 'package:movies/presentation/auth/screen/login_screen.dart';
import 'package:movies/presentation/home/widget/search_field.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static const String routeName = 'profile';

  const ProfileScreen({super.key});

  @override
  ConsumerState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: AppColors.backgroundApp.withOpacity(.5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'My Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 74),
              const CircleAvatar(
                foregroundImage: AssetImage(AppString.assetUrlPlaceholder),
                radius: 80,
              ),
              const SizedBox(height: 24),
              const Text(
                'Email',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 7),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 36,
                  decoration: ShapeDecoration(
                    color: AppColors.backgroundElementGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
                  child: Text(
                    user?.email ?? '',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              const Text(
                'Name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 7),
              InkWell(
                onTap: () {

                },
                child: Container(
                  height: 36,
                  decoration: ShapeDecoration(
                    color: AppColors.backgroundElementGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
                  child: Text(
                      user?.displayName ?? '',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              // Spacer(),
              const SizedBox(height: 65),
              AppButton(color: AppColors.red, textColor: AppColors.white, onTap: () {}, label: 'Save',),
              SizedBox(height: 20,),
              AppButton(color: AppColors.backgroundApp, textColor: AppColors.red, onTap: () async {
                await FirebaseAuth.instance
                    .signOut();
                //     .then((value) => print(value))
                //     .onError((error, stackTrace) => print(error));
                context.goNamed(LoginScreen.routeName);
              }, label: 'log out',)
            ],
          ),
        ),
      ),
    );
  }
}
