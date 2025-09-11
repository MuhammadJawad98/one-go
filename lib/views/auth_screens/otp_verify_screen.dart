import 'package:car_wash_app/providers/auth_provider.dart';
import 'package:car_wash_app/widgets/custom_back_button.dart';
import 'package:car_wash_app/widgets/custom_button.dart';
import 'package:car_wash_app/widgets/custom_overlay.dart';
import 'package:car_wash_app/widgets/custom_text.dart';
import 'package:car_wash_app/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../utils/app_colors.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  String otpCode = '';

  @override
  Widget build(BuildContext context) {
    final size = Responsive.getDynamicSize(context);

    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return CustomOverLay(
          isLoading: provider.isResendOtpLoading,
          child: Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SafeArea(child: Row(children: [CustomImageButton(onTap: ()=> Navigator.pop(context))])),
                  const SizedBox(height: 36),

                  // Title
                  const Center(
                    child: CustomText(
                      text: 'Verify Code',
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Description with email
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1,
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(fontSize: 12),
                          children: [
                            TextSpan(
                              text:
                                  'Please enter the code we just sent to number ',
                              style: TextStyle(color: AppColors.blackColor),
                            ),
                            TextSpan(
                              text: provider.clientNumber,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),

                  // OTP entry using pin_code_fields
                  LayoutBuilder(
                    builder: (context, constraints) {
                      const int otpLength = 6;
                      double gap = 8.0;

                      // Available width inside the current padding
                      final maxW = constraints.maxWidth;

                      // Try with default gap; if too tight, shrink the gap
                      double boxW = (maxW - gap * (otpLength - 1)) / otpLength;
                      if (boxW < 44) {
                        gap = 4.0;
                        boxW = (maxW - gap * (otpLength - 1)) / otpLength;
                      }

                      // Clamp to a sensible range
                      final fieldWidth = boxW.clamp(36.0, 57.0);
                      final fieldHeight = fieldWidth.clamp(44.0, 57.0);

                      return Padding(
                        // Optional: give a tiny horizontal breathing room
                        padding: EdgeInsets.symmetric(horizontal: gap / 2),
                        child: PinCodeTextField(
                          appContext: context,
                          length: otpLength,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          animationType: AnimationType.fade,
                          keyboardType: TextInputType.number,
                          hintCharacter: '-',
                          autoDismissKeyboard: true,
                          hintStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                          pastedTextStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                          animationDuration: const Duration(milliseconds: 300),
                          onChanged: (value) => otpCode = value,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: fieldHeight,
                            fieldWidth: fieldWidth,
                            borderWidth: 1,
                            inactiveColor: AppColors.greyColor,
                            selectedColor: AppColors.primaryColor,
                            activeColor: AppColors.primaryColor,
                            inactiveFillColor: AppColors.fieldBgColor,
                            selectedFillColor: AppColors.fieldBgColor,
                            activeFillColor: AppColors.fieldBgColor,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 36),

                  // Resend
                  CustomText(
                    text: 'Didn’t receive OTP?',
                    color: AppColors.lightGreyTextColor,
                    fontSize: 12,
                  ),
                  GestureDetector(
                    onTap: () => provider.resendOtp(context),
                    child: CustomText(
                      text: 'Resend code',
                      color: AppColors.blackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      textDecoration: TextDecoration.underline,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Verify button
                  CustomButton(
                    text: 'Verify',
                    isLoading: provider.isOtpLoading,
                    onPressed: (){
                      provider.verifyOtp(context, otpCode);
                      // AppNavigation.navigateToDashboardScreen(context);
                    },
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
