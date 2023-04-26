import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niaz_shopping/common/utils/prefs_manager.dart';
import 'package:niaz_shopping/common/widgets/custom_buton.dart';
import 'package:niaz_shopping/common/widgets/drop_loading.dart';
import 'package:niaz_shopping/config/constants.dart';
import 'package:niaz_shopping/features/feature_profile/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:niaz_shopping/features/feature_profile/presentation/bloc/login_bloc/login_data_status.dart';
import 'package:niaz_shopping/features/feature_profile/presentation/bloc/login_bloc/login_event.dart';
import 'package:niaz_shopping/features/feature_profile/presentation/bloc/login_bloc/login_state.dart';
import 'package:niaz_shopping/features/feature_profile/widgets/profile_clip_path.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shimmer/shimmer.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final formKey = GlobalKey<FormState>();
final formKey2 = GlobalKey<FormState>();

final TextEditingController usernameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController codeController = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // get device size
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            ClipPath(
              clipper: ProfileClipPath(),
              child: Container(
                width: width,
                height: height / 3,
                color: CustomColors.lightAmber,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, top: 40),
                  child: Shimmer.fromColors(
                    baseColor: Colors.white,
                    highlightColor: Colors.grey,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ورود به حساب',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'ورود به حساب کاربری قبلی',
                          style: CustomTextStyle.whiteMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'نام و نام خانوادگی',
                      style: CustomTextStyle.darkMedium,
                    ),
                    SizedBox(height: height / 200),
                    SizedBox(
                      height: height / 13,
                      child: TextFormField(
                        controller: usernameController,
                        style: CustomTextStyle.darkSmall,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          fillColor: Colors.grey[300],
                          counterText: "",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: CustomColors.dark,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'نام کاربری خالی است.';
                          } else if (value.length < 2) {
                            return 'نام کاربری باید بیشتر از 2 کاراکتر باشد';
                          } else if (value.length > 20) {
                            return 'نام کاربری باید کمتر از 20 کاراکتر باشد';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    const Text(
                      'شماره همراه',
                      style: CustomTextStyle.darkMedium,
                    ),
                    SizedBox(height: height / 200),
                    SizedBox(
                      height: height / 13,
                      child: TextFormField(
                        controller: phoneController,
                        maxLength: 11,
                        style: CustomTextStyle.darkSmall,
                        textAlign: TextAlign.end,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          fillColor: Colors.grey[300],
                          counterText: "",
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: CustomColors.dark,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'شماره همراه را وارد کنید';
                          } else if (value.length != 11) {
                            return 'شماره همراه اشتباه است';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: height / 6),

                    /// submit button
                    BlocConsumer<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state.loginDataStatus is LoginDataInitStatus) {
                          return CustomButton(
                            width: width,
                            height: height / 14,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<LoginBloc>(context).add(
                                  LoginRequest(
                                    identity: usernameController.text,
                                    password: phoneController.text,
                                  ),
                                );
                              }
                            },
                            text: 'ورود به حساب',
                            textStyle: CustomTextStyle.whiteMedium,
                            color: CustomColors.lightAmber,
                            radius: 10,
                          );
                        }
                        if (state.loginDataStatus is LoginDataLoadingStatus) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Center(
                              child: DropLoading(),
                            ),
                          );
                        }
                        if (state.loginDataStatus is LoginDataErrorStatus) {
                          return Column(
                            children: [
                              CustomButton(
                                width: width,
                                height: height / 14,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<LoginBloc>(context).add(
                                      LoginRequest(
                                        identity: usernameController.text,
                                        password: phoneController.text,
                                      ),
                                    );
                                  }
                                },
                                text: 'تلاش دوباره',
                                textStyle: CustomTextStyle.whiteMedium,
                                color: CustomColors.lightAmber,
                                radius: 10,
                              ),
                              const Text(
                                'کاربری با این مشخصات وجود ندارد',
                                style: CustomTextStyle.darkSmall,
                              ),
                            ],
                          );
                        }
                        if (state.loginDataStatus is LoginDataCompletedStatus) {
                          return CustomButton(
                            width: width,
                            height: height / 14,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<LoginBloc>(context).add(
                                  LoginRequest(
                                    identity: usernameController.text,
                                    password: phoneController.text,
                                  ),
                                );
                              }
                            },
                            text: 'ورود به حساب',
                            textStyle: CustomTextStyle.whiteMedium,
                            color: CustomColors.lightAmber,
                            radius: 10,
                          );
                        }
                        return Container();
                      },
                      listener: (context, state) {
                        if (state.loginDataStatus is LoginDataCompletedStatus) {
                          myBottomSheet(
                            context,
                            width,
                            height,
                            codeController,
                            usernameController,
                            phoneController,
                          );
                        }
                      },
                    ),

                    SizedBox(height: height / 70),

                    CustomButton(
                      width: width,
                      height: height / 14,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: 'بازگشت',
                      textStyle: CustomTextStyle.darkMedium,
                      color: Colors.white,
                      radius: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> myBottomSheet(
    BuildContext context,
    double width,
    double height,
    TextEditingController codeController,
    TextEditingController usernameController,
    TextEditingController phoneController,
  ) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      isDismissible: false,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.04),
              const Center(
                child: Text(
                  'کد ورود را وارد کنید',
                  style: CustomTextStyle.darkMedium,
                ),
              ),
              SizedBox(height: height * 0.06),
              const Text(
                'کد ورود',
                style: CustomTextStyle.darkMedium,
              ),
              SizedBox(height: height * 0.005),
              SizedBox(
                height: height / 13,
                child: Form(
                  key: formKey2,
                  child: TextFormField(
                    controller: codeController,
                    maxLength: 6,
                    style: CustomTextStyle.darkMedium,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'کد ورود الزامی است';
                      }
                      return null;
                    },
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      fillColor: Colors.grey[200],
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 0, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 0, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: CustomColors.dark),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height / 5),
              Center(
                child: CustomButton(
                  width: width / 4,
                  height: height / 15,
                  onPressed: () {
                    if (formKey2.currentState!.validate()) {
                      PrefsManager.saveName(usernameController.text);
                      PrefsManager.readName();
                      PrefsManager.savePhone(phoneController.text);
                      PrefsManager.readPhone();
                      PrefsManager.saveCode(codeController.text);
                      PrefsManager.readCode();
                      Restart.restartApp();
                    }
                  },
                  text: 'تایید و ادامه',
                  textStyle: CustomTextStyle.whiteMedium,
                  color: CustomColors.lightAmber,
                  radius: 10,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
