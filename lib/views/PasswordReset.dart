import '/Controllers/auth-controller.dart'; // Import your AuthController
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/theme_colors.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  var isCodeSent = false.obs;
  var isCodeVerified = false.obs;
  var isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Reset'),
        backgroundColor: ThemeColors.baseThemeColor,
      ),
      body: Stack(
        children: [
          // Top-left circle
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
                   
          // Main content
          Obx(() => isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isCodeSent.value) ...[
                        Text('Enter your email to receive a reset code:'),
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeColors.baseThemeColor,
                            
                            shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(50), // <-- Radius
                          ),
                          ),
                          onPressed: () {
                            if (emailController.text.isNotEmpty) {
                              isLoading.value = true;
                              authController
                                  .sendResetCode(emailController.text.trim())
                                  .then((_) {
                                    isLoading.value = false;
                                    isCodeSent.value = true;
                                  });
                            } else {
                              Get.snackbar('Error', 'Please enter your email.');
                            }
                          },
                          child: Text('Send Reset Code'),
                        ),
                      ],
                      if (isCodeSent.value && !isCodeVerified.value) ...[
                        Text('Enter the reset code sent to your email:'),
                        TextField(
                          controller: codeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Reset Code'),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (codeController.text.isNotEmpty) {
                              isLoading.value = true;
                              authController
                                  .verifyResetCode(emailController.text.trim(), codeController.text.trim())
                                  .then((_) {
                                    isLoading.value = false;
                                    isCodeVerified.value = true;
                                  });
                            } else {
                              Get.snackbar('Error', 'Please enter the reset code.');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeColors.baseThemeColor,
                          ),
                          child: Text('Verify Code'),
                        ),
                      ],
                      if (isCodeVerified.value) ...[
                        Text('Enter your new password:'),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'New Password'),
                        ),
                        TextField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'Confirm Password'),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeColors.baseThemeColor,
                          ),
                          onPressed: () {
                            if (passwordController.text == confirmPasswordController.text) {
                              isLoading.value = true;
                              authController
                                  .resetPasswordWithCode(
                                    emailController.text.trim(),
                                    codeController.text.trim(),
                                    passwordController.text.trim(),
                                  )
                                  .then((_) => isLoading.value = false);
                            } else {
                              Get.snackbar('Error', 'Passwords do not match.');
                            }
                          },
                          child: Text('Reset Password'),
                        ),
                      ],
                    ],
                  ),
                )),
        ],
      ),
    );
  }
}
