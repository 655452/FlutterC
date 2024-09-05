import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/Controllers/auth-controller.dart';
import '/Controllers/global-controller.dart';
import '/services/get_network_manager.dart';
import '/utils/font_size.dart';
import '/utils/size_config.dart';
import '/views/no_internet.dart';
import '/views/sign_up.dart';
import '/widgets/loader.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '/utils/theme_colors.dart';
import 'package:shimmer/shimmer.dart';

import 'PasswordReset.dart';
import 'otp_login_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  final settingController = Get.put(GlobalController());

  GetXNetworkManager _networkManager = GetXNetworkManager();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState

    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        break;
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.detached:
        break;

      case AppLifecycleState.paused:
        // TODO: Handle this case.
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthController authController = AuthController();

  @override
  void didChangeDependencies() {
    _networkManager = Get.put(GetXNetworkManager());
    authController = Get.put(AuthController());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return GetBuilder<GetXNetworkManager>(
      builder: (builder) => (_networkManager.connectionType == 0)
          ? NoInternetPage()
          : GetBuilder<AuthController>(
              init: AuthController(),
              builder: (auth) => Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                    child: Container(
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  // padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Stack(children: [
                    Positioned(
                      top: -50,
                      left: -50,
                      // right:-50,
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: -50,
                      left: -30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 240, 80, 40),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    
                    Positioned(
                      top: -50,
                      left: 300,
                     
                      
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    // Bottom-right circle
                    Positioned(
                      bottom: -50,
                      right: -50,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Center(
                       
                      child: SingleChildScrollView(
                        child: Column(
                            // padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GetBuilder<GlobalController>(
                                init: GlobalController(),
                                builder: (site) => 
                                 GestureDetector(
                                        onTap: () {
                                          // Navigate to the Sign-In page
                                          Get.off(() => SignUpPage()); // Replace SignInPage with your actual sign-in page class
                                        },
                                child:CachedNetworkImage(
                                  
                                  imageUrl: "https://cdn-icons-png.flaticon.com/512/9187/9187604.png",
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    child: Container(
                                      height: 60,
                                      width: 120,
                                      color: Colors.grey,
                                    ),
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[400]!,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                 ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GetBuilder<GlobalController>(
                                init: GlobalController(),
                                builder: (site) => site.customerAppName == null
                                    ? Text('Welcome',
                                        style: GoogleFonts.poppins(
                                          color: ThemeColors.baseThemeColor,
                                          fontSize: FontSize.xxLarge,
                                          fontWeight: FontWeight.w600,
                                        ))
                                    : Text(
                                        '${site.customerAppName}',
                                        style: GoogleFonts.poppins(
                                          color: ThemeColors.baseThemeColor,
                                          fontSize: FontSize.xxLarge,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                              
                              Text(
                                "Login to your account.",
                                style: GoogleFonts.poppins(
                                  color: ThemeColors.greyTextColor,
                                  fontSize: FontSize.medium,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 30),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    ///Email Input Field
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                      height: 60,
                                      child: TextFormField(
                                        controller: _emailController,
                                        validator: (value) {
                                          if (_emailController.text.isEmpty) {
                                            return "This field can't be empty";
                                          }
                                          return null;
                                        },
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        cursorColor: ThemeColors.primaryColor,
                                        decoration: InputDecoration(
                                          labelText: 'Email Address',
                                          labelStyle: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                          hintText: 'Enter your email here',
                                          hintStyle: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                          prefixIcon: Icon(
                                            Icons.email_outlined,
                                            color: ThemeColors.baseThemeColor,
                                          ),
                                          fillColor: Colors.black,
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            borderSide: BorderSide(
                                              color: ThemeColors.baseThemeColor,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            borderSide: BorderSide(
                                              width: 0.2,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16),

                                    ///Password Input Field
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                      height: 60,
                                      child: TextFormField(
                                        controller: _passwordController,
                                        validator: (value) {
                                          if (_passwordController
                                              .text.isEmpty) {
                                            return "This field can't be empty";
                                          }
                                          return null;
                                        },
                                        obscureText: true,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                        ),
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        cursorColor: ThemeColors.primaryColor,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          labelStyle: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                          hintText: 'Enter your password here',
                                          hintStyle: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: ThemeColors.baseThemeColor,
                                          ),
                                          fillColor: Colors.black,
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            borderSide: BorderSide(
                                              color: ThemeColors.baseThemeColor,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            borderSide: BorderSide(
                                              width: 0.2,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),

                                    ///Sign in button
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                      height: 50,
                                      width: double.infinity,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0), // <-- Margin
                                        child:ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ThemeColors
                                              .baseThemeColor, // background
                                          foregroundColor:
                                              Colors.white, // foreground
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                50), // <-- Radius
                                          ),
                                        ),
                                        onPressed: () async {
                                          auth.loginOnTap(
                                              email: _emailController.text
                                                  .toString()
                                                  .trim(),
                                              pass: _passwordController.text
                                                  .toString()
                                                  .trim());
                                        },
                                        child: Text(
                                          'Sign In',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      )
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Or",
                                          style: GoogleFonts.poppins(
                                            // color: ThemeColors.whiteTextColor,
                                            fontSize: FontSize.medium,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      height: 50,
                                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                      width: double.infinity,
                                      child: Container(
                                         margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0), 
                                        child:ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ThemeColors.baseThemeColor, // background
                                          foregroundColor: Colors.white, // foreground
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50), // <-- Radius
                                          ),
                                        ),
                                        onPressed: () {
                                          // Navigate to the Forgot Password page
                                          Get.to(() => PasswordResetPage());
                                        },
                                        child: Text(
                                          'Forgot Password',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      )
                                    ),

                                  SizedBox(height: 10),
                                  // Container(
                                  //   height: 50,
                                  //   width: double.infinity,
                                  //   child: ElevatedButton(
                                  //     style: ElevatedButton.styleFrom(
                                  //       backgroundColor: ThemeColors
                                  //           .titleColor, // background
                                  //       foregroundColor:
                                  //           Colors.white, // foreground
                                  //       shape: RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.circular(
                                  //             10), // <-- Radius
                                  //       ),
                                  //     ),
                                  //     onPressed: () {
                                  //       Get.to(() => OtpLoginPage());
                                  //     },
                                  //     child: Text(
                                  //       'OTP Login',
                                  //       style: TextStyle(
                                  //           color: Colors.white,
                                  //           fontWeight: FontWeight.bold),
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(height: 20),
                                  // Container(
                                  //   height: 50,
                                  //   width: double.infinity,
                                  //   child: ElevatedButton(
                                  //     style: ElevatedButton.styleFrom(
                                  //       backgroundColor: ThemeColors
                                  //           .facebookColor, // background
                                  //       foregroundColor:
                                  //           Colors.white, // foreground
                                  //       shape: RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.circular(
                                  //             10), // <-- Radius
                                  //       ),
                                  //     ),
                                  //     onPressed: () async {
                                  //       auth.loginFB();
                                  //     },
                                  //     child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.center,
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.center,
                                  //       children: const [
                                  //         CircleAvatar(
                                  //           backgroundImage: AssetImage(
                                  //               "assets/images/facebook.png"),
                                  //         ),
                                  //         Padding(
                                  //           padding:
                                  //               EdgeInsets.only(left: 10.0),
                                  //           child: Text("Login with Facebook"),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(height: 20),
                                  // Container(
                                  //   height: 50,
                                  //   width: double.infinity,
                                  //   child: ElevatedButton(
                                  //     style: ElevatedButton.styleFrom(
                                  //       backgroundColor: ThemeColors
                                  //           .googleColor, // background
                                  //       foregroundColor:
                                  //           Colors.white, // foreground
                                  //       shape: RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.circular(
                                  //             10), // <-- Radius
                                  //       ),
                                  //     ),
                                  //     onPressed: () async {
                                  //       auth.loginGoogle();
                                  //     },
                                  //     child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.center,
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.center,
                                  //       children: const [
                                  //         CircleAvatar(
                                  //           backgroundImage: AssetImage(
                                  //               "assets/images/google.jpg"),
                                  //         ),
                                  //         Padding(
                                  //           padding:
                                  //               EdgeInsets.only(left: 10.0),
                                  //           child:
                                  //               Text("Login with Google    "),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Don't have an account? ",
                                          style: GoogleFonts.poppins(
                                            // color: ThemeColors.whiteTextColor,
                                            fontSize: FontSize.medium,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.off(() => SignUpPage());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Text(
                                              "Sign Up",
                                              style: GoogleFonts.poppins(
                                                color:
                                                    ThemeColors.baseThemeColor,
                                                fontSize: FontSize.medium,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ]),
                      ),
                    ),
                    auth.loader
                        ? Positioned(
                            child: Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white60,
                                child: Center(child: Loader())),
                          )
                        : SizedBox.shrink(),
                  ]),
                )),
              ),
            ),
    );
  }
}
