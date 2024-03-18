import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/constant/color.dart';
import 'package:movies/core/constant/string.dart';
import 'package:movies/core/widget/app_button.dart';
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
                  child: const Text(
                    '10',
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
                  child: const Text(
                    '50',
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
                'Note',
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
                  child: const Text(
                    'note',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              AppButton(color: AppColors.red, onTap: () {}, label: 'Save')
            ],
          ),
        ),
      ),
    );
  }
}
