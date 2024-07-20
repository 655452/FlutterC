import 'package:flutter/material.dart';
import 'package:food_ex/utils/theme_colors.dart';
import 'package:get/get.dart';

import '../Controllers/otp_controller.dart';
import '../constants/constant.dart';
import '../widgets/loader.dart';

class OtpLoginPage extends StatefulWidget {
  const OtpLoginPage({Key? key}) : super(key: key);

  @override
  State<OtpLoginPage> createState() => _OtpLoginPageState();
}

class _OtpLoginPageState extends State<OtpLoginPage> {
  late final TextEditingController emailController;
  OtpController otpController = Get.put(OtpController());
  bool _isButtonActive = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = OtpController().emailController;
    emailController.addListener(() {
      final _isButtonActive = emailController.text.isNotEmpty;
      setState(() {
        this._isButtonActive = _isButtonActive;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

//Email pattern input validation
  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);

    String patternPhone = r'(^(?:[+0]9)?[0-9]{10}$)';
    RegExp regExp = new RegExp(patternPhone);
    if (regex.hasMatch(value!)) {
      return null;
    } else if (regExp.hasMatch(value)) {
      return null;
    } else {
      return 'Please enter valid email or phone number';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'OTP Login',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          backgroundColor: ThemeColors.baseThemeColor,
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 18,
                        ),
                        const Text(
                          "Enter the email address associated with your",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff706881),
                          ),
                        ),
                        const Text(
                          "account",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff706881),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Email",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12),
                            ),
                            Text(
                              "*",
                              style:
                                  TextStyle(color: ThemeColors.baseThemeColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                          height: 68,
                          child: TextFormField(
                            controller: emailController,
                            textInputAction: TextInputAction.done,
                            validator: (value) => validateEmail(value),
                            keyboardType: TextInputType.text,
                            cursorColor: ThemeColors.baseThemeColor,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                top: 0,
                                left: 15,
                              ),
                              fillColor: const Color(0xffF2CDD4),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: ThemeColors.baseThemeColor,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: ThemeColors.baseThemeColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: ThemeColors.baseThemeColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Color(0xffF2CDD4),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.baseThemeColor,
                        surfaceTintColor: ThemeColors.baseThemeColor, // background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ),
                      ),
                      onPressed: _isButtonActive
                          ? () {
                              setState(() {
                                _isButtonActive = false;
                                //emailController.clear();
                              });
                              if (_formKey.currentState!.validate()) {
                                otpController
                                    .sendOTP(emailController.text.trim());
                              }
                            }
                          : null,
                      child: const Text(
                        'Get code',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      GetBuilder<OtpController>(
                        init: otpController,
                        builder: (loader) {
                          return loader.isLoading
                              ? Positioned(
                                  child: Container(
                                      height: ScreenSize(context).mainWidth,
                                      width: ScreenSize(context).mainWidth,
                                      color: Colors.white60,
                                      child: Center(child: Loader())),
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
