import 'package:car_wash_app/providers/dashboard_provider.dart';
import 'package:car_wash_app/routes/app_navigation.dart';
import 'package:car_wash_app/services/api_manager.dart';
import 'package:car_wash_app/utils/api_endpoint.dart';
import 'package:car_wash_app/utils/app_alerts.dart';
import 'package:car_wash_app/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoginLoading = false;
  bool isOtpLoading = false;
  bool isSignUpLoading = false;
  bool isResendOtpLoading = false;
  String clientNumber = '';
  String exchangeUuid = '';

  void resetProvider() {
    isLoginLoading = false;
    isOtpLoading = false;
    isSignUpLoading = false;
    isResendOtpLoading = false;
    clientNumber = '';
    notifyListeners();
  }

  void updateLoginLoader(bool val) {
    isLoginLoading = val;
    notifyListeners();
  }

  void updateOtpLoader(bool val) {
    isOtpLoading = val;
    notifyListeners();
  }

  void updateSignUpLoader(bool val) {
    isSignUpLoading = val;
    notifyListeners();
  }

  void updateResendLoader(bool val) {
    isResendOtpLoading = val;
    notifyListeners();
  }

  Future<void> doLogin(BuildContext context, String number) async {
    try {
      final cleanedNumber = validateAndFormatSaudiNumber(number);
      if (cleanedNumber == null) {
        HelperFunctions.showAlertPopup(
          'Please enter a valid Saudi phone number',
        );
        return;
      }

      updateLoginLoader(true);
      clientNumber = "+$cleanedNumber";
      // Make the API call
      final response = await ApiManager.post(ApiEndpoint.login, {
        "mobile": "+$cleanedNumber",
      });

      updateLoginLoader(false);

      // Handle response
      if (response['status'] == true) {
        AppNavigation.navigateToOtpVerifyScreen(context);
        AppAlerts.showSnackBar(
          response['data']['message'] ?? 'OTP sent to your mobile number',
        );
        exchangeUuid = response['data']['exchangeUuid'] ?? '';
      } else {
        HelperFunctions.handleApiMessages(response);
      }
    } catch (e) {
      updateLoginLoader(false);
      HelperFunctions.showAlertPopup('An error occurred: ${e.toString()}');
    }
  }

  Future<void> resendOtp(BuildContext context) async {
    try {
      final cleanedNumber = validateAndFormatSaudiNumber(clientNumber);
      if (cleanedNumber == null) {
        HelperFunctions.showAlertPopup(
          'Please enter a valid Saudi phone number',
        );
        return;
      }

      updateResendLoader(true);

      // Make the API call for OTP resend
      final response = await ApiManager.post(ApiEndpoint.login, {
        "mobile": "+$cleanedNumber",
      });

      updateResendLoader(false);

      // Handle response
      if (response['status'] == true) {
        AppAlerts.showSnackBar(
          response['data']['message'] ?? 'OTP resent to your mobile number',
        );
        exchangeUuid = response['data']['exchangeUuid'] ?? '';
      } else {
        HelperFunctions.handleApiMessages(response);
      }
    } catch (e) {
      updateLoginLoader(false);
      AppAlerts.showSnackBar(
        'An error occurred: ${e.toString()}',
        statusCode: 1,
      );
    }
  }

  Future<void> verifyOtp(BuildContext context, String otp) async {
    try {
      // Validate OTP input
      if (otp.isEmpty || otp.length != 6) {
        // Assuming 4-digit OTP
        AppAlerts.showSnackBar(
          'Please enter a valid 6-digit OTP code',
          statusCode: 1,
        );
        return;
      }

      updateOtpLoader(true); // Show loading indicator

      // Make the API call for OTP verification
      final response = await ApiManager.post(ApiEndpoint.verifyOtp, {
        "exchangeUuid": exchangeUuid,
        "code": otp,
      });

      updateOtpLoader(false); // Hide loading indicator

      // Handle response
      if (response['status'] == true) {
        // Successful verification
        AppAlerts.showSnackBar(
          response['data']['message'] ?? 'OTP verified successfully',
        );
        Provider.of<DashboardProvider>(context,listen: false).setUserModel(response['data']);
        // Navigate to the appropriate screen (e.g., home or profile setup)
        AppNavigation.navigateToDashboardScreen(context);

        // Optionally save user token or other auth data
        // await SharedPreferencesHelper.saveAuthToken(response['data']['token']);
      } else {
        // Failed verification
        HelperFunctions.handleApiMessages(response);
      }
    } catch (e) {
      updateLoginLoader(false); // Hide loading indicator if still showing
      AppAlerts.showSnackBar(
        'An error occurred: ${e.toString()}',
        statusCode: 1,
      );
    }
  }

  String? validateAndFormatSaudiNumber(String number) {
    // Validate the input
    if (number.isEmpty) {
      return null;
    }

    // Clean the number by removing any non-digit characters
    String cleanedNumber = number.replaceAll(RegExp(r'[^0-9]'), '');

    // Handle Saudi numbers
    if (!cleanedNumber.startsWith('966')) {
      // If it's a Saudi number without country code but starts with 5, add 966
      if (cleanedNumber.startsWith('5') && cleanedNumber.length == 9) {
        cleanedNumber = '966$cleanedNumber';
      }
      // If it's a Saudi number with 0 prefix (like 05...), remove 0 and add 966
      else if (cleanedNumber.startsWith('05') && cleanedNumber.length == 10) {
        cleanedNumber = '966${cleanedNumber.substring(1)}';
      }
      // If it's a Saudi number with +966 already, just clean it
      else if (cleanedNumber.startsWith('966') && cleanedNumber.length >= 12) {
        // Already correct format
      }
      // Otherwise, assume it's a Saudi number and add 966
      else if (cleanedNumber.length == 9) {
        cleanedNumber = '966$cleanedNumber';
      }
    }

    // Final validation
    if (cleanedNumber.length < 12 || !cleanedNumber.startsWith('966')) {
      return null;
    }

    return cleanedNumber;
  }

  void logout(BuildContext context) {
    HelperFunctions.clearPreference();
    AppNavigation.navigateToLoginScreen(context);
  }
}
