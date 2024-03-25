import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/core/constant/color.dart';
import 'package:movies/core/constant/string.dart';
import 'package:movies/core/until/untils.dart';
import 'package:movies/core/widget/app_button.dart';
import 'package:movies/presentation/home/home_screen.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String routeName = 'login';

  const LoginScreen({super.key});

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final FormGroup _formGroup = FormGroup({
    'email': FormControl<String>(value: '', validators: [
      Validators.email,
      Validators.required,
    ]),
    'password': FormControl<String>(value: '', validators: [
      Validators.minLength(8),
      Validators.required,
    ])
  });

  final isObscure = ValueNotifier<bool>(true);
  // ref.listen(signInProvider, (previous, next) async {
  // if (next.error != null) {
  // AppToast.showError(context, message: next.error!);
  // return;
  // }
  //
  // if (next.success == true) {
  // print('fuck');
  // canMove = false;
  //
  // final user = locator<LocalService>().user;
  // if (locator<LocalService>().hasPin(user.email)) {
  // context.pushNamed(PinScreen.enterRouteName);
  // return ;
  // }
  // else {
  // context.pushNamed(PinScreen.createRouteName).then((value) => canMove = false);
  // return ;
  // }
  // }
  // });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unFocus(context),
      child: Scaffold(
        body: ReactiveForm(
          formGroup: _formGroup,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.black,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 37),
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          AppString.assetUrlLogo,
                          width: 80,
                          height: 80,
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          'Welcome to Movies',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(
                          height: 64,
                        ),
                        ReactiveTextField<String>(
                          style: const TextStyle(color: AppColors.white),
                          formControlName: 'email',
                          decoration: const InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(color: AppColors.white)),
                        ),
                        const SizedBox(height: 26),
                        ValueListenableBuilder(
                          valueListenable: isObscure,
                          builder: (context, value, child) =>
                              ReactiveTextField<String>(
                            obscureText: value,
                            style: const TextStyle(color: AppColors.white),
                            formControlName: 'password',
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(color: AppColors.white),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      isObscure.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: AppColors.white),
                                  onPressed: () => isObscure.value = !value,
                                )),
                          ),
                        ),
                        const SizedBox(height: 50),
                        AppButton(
                          // loading: state.submitting,
                          label: 'Login',
                          onTap: () async {
                            unFocus(context);
                            if (_formGroup.invalid) {
                              return;
                            }
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email:
                                        _formGroup.rawValue['email'] as String,
                                    password: _formGroup.rawValue['password']
                                        as String);
                            //     .then((value) => print(value))
                            //     .onError((error, stackTrace) => print(error));
                            context.goNamed(HomeScreen.routeName);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
