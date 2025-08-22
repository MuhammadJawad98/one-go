import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../localization/language_constraints.dart';
import '../main.dart';
import '../providers/language_provider.dart';
import '../utils/app_colors.dart';
import '../utils/print_log.dart';
import '../widgets/custom_text.dart';
import 'app_alerts.dart';
import 'app_strings.dart';
import 'application_shared_instance.dart';

class HelperFunctions {
  ///this funciton is used in whatsup section for showing custom dateTime
  static String getDateTimeString(String? dateTime, {String? format}) {
    if (dateTime != null || dateTime!.isNotEmpty) {
      try {
        DateTime dt = DateTime.parse(dateTime);
        String formattedDate =
            DateFormat(format ?? 'EEE - MMM dd,yyyy HH:mm a').format(dt);
        return formattedDate;
      } catch (e) {
        return "";
      }
    } else {
      return '';
    }
  }

  static saveInPreference(String preName, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(preName, value);
    PrintLogs.printLog("Data saved successfully");
  }

  static saveStringListInPreference(String preName, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(preName, value);
  }

  static Future<List<String>> getStringListInPreference(String preName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(preName) ?? [];
  }

  static clearPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static saveBoolInPreference(String preName, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(preName, value);
  }

  static Future<bool> getBoolFromPreference(String preName) async {
    final prefs = await SharedPreferences.getInstance();
    bool returnValue = prefs.getBool(preName) ?? false;
    return returnValue;
  }

  static Future<String> getFromPreference(String preName) async {
    String returnValue = "";

    final prefs = await SharedPreferences.getInstance();
    returnValue = prefs.getString(preName) ?? "";
    return returnValue;
  }

  static bool isStringAValidUrl(String inputVal) {
    bool isValid = false;
    Uri? val = Uri.tryParse(inputVal);
    if (val == null) {
      isValid = false;
    } else {
      isValid = val.isAbsolute;
    }

    return isValid;
  }

  static bool isInteger(String number) {
    bool isValid = false;
    int? val = int.tryParse(number);
    if (val == null) {
      isValid = false;
    } else {
      isValid = true;
    }

    return isValid;
  }

  static bool isValidPassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,16}$';
    RegExp regex = RegExp(pattern);
    if (!(value.contains(regex))) {
      return false;
    } else {
      return true;
    }
  }

  static bool isValidEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";

    RegExp regex = RegExp(pattern);
    if (!(value.contains(regex))) {
      return false;
    } else {
      return true;
    }
  }

  static bool isPdfUrl(String value) {
    String pattern = r"(http(s?):)([/|.|\w|\s|-])*\.pdf";

    RegExp regex = RegExp(pattern);
    if (!(value.contains(regex))) {
      return false;
    } else {
      return true;
    }
  }

  static bool isImageUrl(String value) {
    String pattern =
        r"(http(s?):)([/|.|\w|\s|-])*\.(?:jpg|jpeg|gif|png|webp|bmp)";

    RegExp regex = RegExp(pattern);
    if (!(value.contains(regex))) {
      return false;
    } else {
      return true;
    }
  }

  static String convertUTCToLocal(String utcTime) {
    String returnValue = "";

    PrintLogs.printLog("The UTC Time is : $utcTime");
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(utcTime, true);
    var dateLocal = dateTime.toLocal();

    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    returnValue = formatter.format(dateLocal);

    return returnValue;
  }

  static String decodeJsonString(String input) {
    String returnValue = '';
    try {
      var decodedJSON = json.decode(input);
      returnValue = decodedJSON.toString();
    } on Exception catch (_) {
      returnValue = input;
    }
    return returnValue;
  }

  static bool hasValidUrl(String value) {
    String pattern =
        r'^((http|https):\/\/.)[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  static bool hasValidBaseUrl(String value) {
    // Improved regex pattern for base URLs
    String pattern = r'^(https?:\/\/)' // Requires http or https
        r'(([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,}|localhost|\d{1,3}(\.\d{1,3}){3})' // Domain, localhost, or IP
        r'(:\d+)?' // Optional port
        r'(\/.*)?$'; // Optional path
    RegExp regExp = RegExp(pattern);

    // Validate input
    if (value.isEmpty) {
      return false; // URL cannot be empty
    } else if (!regExp.hasMatch(value)) {
      return false; // URL doesn't match the pattern
    }

    return true; // Valid base URL
  }

  static Future<String>? pickDate(BuildContext context,
      {DateTime? initialDate,
      DateTime? firstDate,
      DateTime? lastDate,
      String pickedDateString = '',
      DateFormat? dateFormat}) async {
    String pickedDate = pickedDateString;
    DateFormat ourFormat = dateFormat ?? DateFormat('yyyy-MM-dd');
    FocusScope.of(context).requestFocus(FocusNode());
    await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1900, 01, 01),
      lastDate: lastDate ?? DateTime(2050, 01, 01),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                    primary: AppColors.primaryColor,
                    onPrimary: AppColors.whiteColor,
                    onSurface: AppColors.primaryColor),
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        foregroundColor: AppColors.primaryColor))),
            child: child!);
      },
    ).then((date) {
      if (date != null) {
        var formattedDate = ourFormat.format(date);
        pickedDate = formattedDate.toString();
      }
    });
    return pickedDate;
  }

  // static Future<void> launchInBrowser(String url, BuildContext context) async {
  //   if (!url.contains("https://") &&
  //       !url.contains("http://") &&
  //       !url.startsWith("mailto:") &&
  //       !url.startsWith("tel:") &&
  //       !url.startsWith("sms:")) {
  //     url = Uri.encodeFull("https://$url");
  //   }
  //   PrintLogs.printLog(url);
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  //   } else {
  //     PrintLogs.printLog("Invalid url ::$url");
  //   }
  // }
  //
  static Future<dynamic> pickImage(ImageSource imageSource) async {
    File imageFile;
    try {
      final file =
          await ImagePicker().pickImage(source: imageSource, imageQuality: 50, maxHeight: 480, maxWidth: 640);
      if (file != null) {
        imageFile = File(file.path);
        return imageFile;
      } else {
        PrintLogs.printLog("No image selected");
        return null;
      }
    } catch (e) {
      PrintLogs.printLog(e);
    }
  }


  // static Future<dynamic> pickFile() async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles();
  //     if (result != null) {
  //       File file = File(result.files.single.path!);
  //       return file;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     PrintLogs.printLog(e);
  //     return null;
  //   }
  // }

  // static Future<dynamic> pickMulitipleImage() async {
  //   List<XFile> imageFiles = [];
  //   try {
  //     imageFiles = await ImagePicker().pickMultiImage(imageQuality: 50);
  //     if (imageFiles.isNotEmpty) {
  //       return imageFiles;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     PrintLogs.printMessgae(e);
  //   }
  // }
  //
  // static Future<DateTimeRange?> showDataRangePicker(
  //     BuildContext context) async {
  //   return await showDateRangePicker(
  //       context: context,
  //       firstDate: DateTime(2023),
  //       lastDate: DateTime(3023),
  //       builder: (context, child) {
  //         return Theme(
  //           data: ThemeData.light().copyWith(
  //               colorScheme:
  //               const ColorScheme.light(primary: AppColors.primaryColor)),
  //           child: child!,
  //         );
  //       });
  // }

  static Future<String> convertToBase64(File file) async {
    var bytes = file.readAsBytesSync();
    String base64string = base64.encode(bytes);

    return base64string;
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  // String userRoles(){
  //   String role = '';
  //   if(DataManager().userRole == "1"){
  //     role = "Super Admin";
  //   }else if(DataManager().userRole == "2"){
  //     role = "Company Owner";
  //   }else if(DataManager().userRole == "3"){
  //     role = "Company Admin";
  //   }else if(DataManager().userRole == "4"){
  //     role = "Event Owner";
  //   }else if(DataManager().userRole == "5"){
  //     role = "Booth Admin";
  //   }else if(DataManager().userRole == "6"){
  //     role = "Booth Rep";
  //   }
  //   return role;
  // }
  static List<Color> lightColors = [
    const Color(0xFFADD8E6), // Light Blue
    const Color(0xFFFFB6C1), // Light Pink
    const Color(0xFFE6E6FA), // Light Purple
    const Color(0xFFFFC0CB), // Light Rose
    const Color(0xFFFFD700), // Light Gold
    const Color(0xFF90EE90), // Light Green
    const Color(0xFFFFFFE0), // Light Yellow
    const Color(0xFFF08080), // Light Coral
    const Color(0xFFE6E6FA), // Light Lavender
    const Color(0xFFFFA07A), // Light Salmon
    const Color(0xFFE0FFFF), // Light Orchid
    const Color(0xFF98FB98), // Light Mint
    const Color(0xFFFFDAB9), // Light Peach
    const Color(0xFFAFEEEE), // Light Turquoise
    const Color(0xFFF5F5DC), // Light Beige
    const Color(0xFFD3D3D3), // Light Lavender
    const Color(0xFF87CEFA), // Light Sky Blue
    const Color(0xFFD3D3D3), // Light Gray
    const Color(0xFFC0C0C0), // Light Silver
    const Color(0xFF00CED1), // Light Teal
  ];

  static String getFileType(String url) {
    int dotIndex = url.lastIndexOf('.');
    if (dotIndex != -1 && dotIndex < url.length - 1) {
      return url.substring(dotIndex + 1);
    } else {
      return ''; // No extension found
    }
  }

  // static  List<SelectionObject> quantityList = [
  //   SelectionObject(id: '1', title: '1', value: '1'),
  //   SelectionObject(id: '2', title: '2', value: '2'),
  //   SelectionObject(id: '3', title: '3', value: '3'),
  //   SelectionObject(id: '4', title: '4', value: '4'),
  //   SelectionObject(id: '5', title: '5', value: '5'),
  //   SelectionObject(id: '6', title: '6', value: '6'),
  //   SelectionObject(id: '7', title: '7', value: '7'),
  //   SelectionObject(id: '8', title: '8', value: '8'),
  //   SelectionObject(id: '9', title: '9', value: '9'),
  //   SelectionObject(id: '10', title: '10', value: '10'),
  //   SelectionObject(id: '11', title: '+/-', value: '+/-'),
  //   SelectionObject(id: '12', title: '.', value: '.'),
  //   SelectionObject(id: '13', title: 'Qty', value: 'qty'),
  //   SelectionObject(id: '14', title: 'Disc', value: 'disc'),
  //   SelectionObject(id: '15', title: 'Price', value: 'price'),
  //   SelectionObject(id: '16', title: '⌫', value: 'remove'),
  // ];

  static String decodeUnicode(String encodedText) {
    return encodedText.replaceAllMapped(RegExp(r'\\u([0-9A-Fa-f]{4})'),
        (Match match) {
      return String.fromCharCode(int.parse(match.group(1)!, radix: 16));
    });
  }

  static String truncateDecimal(String value) {
    if (value.contains('.')) {
      return value.split('.')[0]; // Take the part before the decimal point
    }
    return value; // If no decimal point, return the value as it is
  }

  // static List<dynamic> getPaymentMethods(){
  //   return [
  //     {
  //       "id": 37,
  //       "name": "Cash",
  //       "is_default": false
  //     },
  //     {
  //       "id": 38,
  //       "name": "Bank",
  //       "is_default": true
  //     },
  //     {
  //       "id": 39,
  //       "name": "Bank - ToYo",
  //       "is_default": false
  //     },
  //     {
  //       "id": 40,
  //       "name": "Bank - Jahez",
  //       "is_default": false
  //     },
  //     {
  //       "id": 42,
  //       "name": "Bank - Hungerstation",
  //       "is_default": false
  //     },
  //     {
  //       "id": 43,
  //       "name": "Cash - Hungerstation",
  //       "is_default": false
  //     },
  //     {
  //       "id": 123,
  //       "name": "Online Credit Hunger Station",
  //       "is_default": false
  //     },
  //     {
  //       "id": 197,
  //       "name": "Bank - The Chefz",
  //       "is_default": false
  //     },
  //     {
  //       "id": 211,
  //       "name": "Cash",
  //       "is_default": false
  //     },
  //     {
  //       "id": 263,
  //       "name": "Telr",
  //       "is_default": false
  //     },
  //     {
  //       "id": 315,
  //       "name": "Bank - ToYo",
  //       "is_default": false
  //     },
  //     {
  //       "id": 357,
  //       "name": "Bank - Hungerstation",
  //       "is_default": false
  //     },
  //     {
  //       "id": 364,
  //       "name": "Keeta On-line",
  //       "is_default": false
  //     },
  //     {
  //       "id": 365,
  //       "name": "Ninja On-line",
  //       "is_default": false
  //     }
  //   ];
  // }
  static Map<String, dynamic> convertToStringKeyedMap(
      Map<Object?, Object?> map) {
    return map.map((key, value) {
      if (value is Map<Object?, Object?>) {
        return MapEntry(key.toString(), convertToStringKeyedMap(value));
      } else if (value is List) {
        return MapEntry(
          key.toString(),
          value
              .map((element) => element is Map<Object?, Object?>
                  ? convertToStringKeyedMap(element)
                  : element)
              .toList(),
        );
      } else {
        return MapEntry(key.toString(), value);
      }
    });
  }

  ///exception handling toast
  static void showErrorToast(dynamic result) {
    var context = NavigationService.navigatorKey.currentState!.context;
    String msg = getTranslated(context, AppStrings.somethingWentWrong);
    if (result != null &&
        result['error'] != null &&
        result['error']['message'] is String) {
      msg = result['error']['message'].toString();
    } else if (result != null &&
        result['result']['message'] != null &&
        result['result']['message'] is String) {
      msg = result['result']['message'].toString();
    }
    AppAlerts.showSnackBar(msg, statusCode: 1);
  }

  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static String getFormattedType(String type) {
    switch (type) {
      case "not_prepared":
        return 'Not Prepared';
      case "prepared":
        return 'Prepared';
      case "cancelled":
        return 'Cancelled';
      case "paid":
        return 'Paid';
      case "draft":
        return 'Draft';
      case "invoiced":
        return 'Invoiced';
      case "delivered":
        return 'Delivered';
      case "ongoing":
        return 'Ongoing';
      default:
        return '';
    }
  }

  static Color getStatusColor(String type) {
    switch (type) {
      case "not_prepared" || "Not Prepared" || 'not prepared':
        return AppColors.greenColor;
      case "prepared" || 'Prepared' || 'prepared':
        return AppColors.primaryColor;
      case "cancelled" || 'Cancelled':
        return AppColors.redAccentColor;
      case "paid" || "Paid":
        return AppColors.primaryColor;
      case "draft" || "Draft":
        return AppColors.orangeColor;
      case "invoiced" || "Invoiced":
        return AppColors.primaryColor;
      case "delivered" || "Delivered":
        return AppColors.primaryColor;
      case "ongoing" || "Ongoing":
        return AppColors.primaryGreenColor;
      default:
        return AppColors.greyColor;
    }
  }

  // static Future<DateTime?> pickDate({
  //   required BuildContext context,
  //   DateTime? initialDate,
  //   DateTime? firstDate,
  //   DateTime? lastDate,
  // }) async {
  //   final DateTime now = DateTime.now();
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: initialDate ?? now,
  //     firstDate: firstDate ?? DateTime(now.year - 5),
  //     lastDate: lastDate ?? DateTime(now.year + 10),
  //     builder: (context, child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: const ColorScheme.light(
  //               primary: AppColors.primaryColor,
  //               onPrimary: Colors.white,
  //               onSurface: AppColors.inputDataDefaultColor),
  //           textButtonTheme: TextButtonThemeData(
  //             style:
  //                 TextButton.styleFrom(foregroundColor: AppColors.primaryColor),
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //
  //   return picked;
  // }

  static Future<TimeOfDay?> pickTime({
    required BuildContext context,
    TimeOfDay? initialTime,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
                primary: AppColors.primaryColor,
                onPrimary: Colors.white,
                onSurface: AppColors.inputDataDefaultColor),
            textButtonTheme: TextButtonThemeData(
              style:
                  TextButton.styleFrom(foregroundColor: AppColors.primaryColor),
            ),
          ),
          child: child!,
        );
      },
    );

    return picked;
  }

  static Future<void> launchAction({
    required LaunchType type,
    required String value,
    String? subject,
    String? body,
  }) async {
    Uri uri;

    switch (type) {
      case LaunchType.phone:
        uri = Uri(scheme: 'tel', path: value);
        break;

      case LaunchType.sms:
        uri = Uri(scheme: 'sms', path: value);
        break;

      case LaunchType.email:
        uri = Uri(
          scheme: 'mailto',
          path: value,
          queryParameters: {
            if (subject != null) 'subject': subject,
            if (body != null) 'body': body,
          },
        );
        break;

      case LaunchType.url:
        uri = Uri.parse(value);
        break;
    }

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: type == LaunchType.url
            ? LaunchMode.externalApplication
            : LaunchMode.platformDefault,
      );
    } else {
      throw 'Could not launch $uri';
    }
  }

  static void handleApiMessages(Map? result, {bool success = false}) {
    final context = NavigationService.navigatorKey.currentContext!;

    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final isEnglish = languageProvider.selectedIndex == 0;

    String getDefaultError() => getTranslated(context, AppStrings.somethingWentWrong);

    void showMessage(dynamic message) {
      if (message is String) {
        AppAlerts.showSnackBar(message, statusCode: success ? 0 : 1);
      } else if (message is List) {
        // Join list messages with newlines or other separator
        AppAlerts.showSnackBar(message.join('\n'), statusCode: success ? 0 : 1);
      }
    }

    if (result == null) {
      AppAlerts.showSnackBar(getDefaultError(), statusCode: 1);
      return;
    }

    // Handle English messages
    if (isEnglish) {
      if (result['message'] != null) {
        showMessage(result['message']);
      } else if (result['messages'] != null) {
        showMessage(result['messages']);
      } else {
        AppAlerts.showSnackBar(getDefaultError(), statusCode: 1);
      }
      return;
    }

    // Handle Arabic messages
    if (result['message_ar'] != null) {
      showMessage(result['message_ar']);
    } else if (result['messages_ar'] != null) {
      showMessage(result['messages_ar']);
    } else if (result['message'] != null) {
      // Fallback to English message if Arabic not available
      showMessage(result['message']);
    } else if (result['messages'] != null) {
      // Fallback to English messages if Arabic not available
      showMessage(result['messages']);
    } else {
      AppAlerts.showSnackBar(getDefaultError(), statusCode: 1);
    }
  }

  static String getPictureUrl(String img){
    String url = img;
    if(!url.contains(DataManager().baseUrlAssets)){
      url = "${DataManager().baseUrlAssets}/$img";
    }
    return url;
  }

  // static void checkPlatformAndOpenUrl(BuildContext context, String url,String name)async{
  //   // if (Platform.isAndroid) {
  //   //   AndroidIntent intent = AndroidIntent(
  //   //       action: 'action_view',
  //   //       data: url);
  //   //   await intent.launch();
  //   // } else{
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomWebViewScreen(webUrl: url, title: name,isPdf: true)));
  //   // }
  // }

 static String formatTimeOfDay(TimeOfDay time,{String format = 'HH:mm'}) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final formattedTime = DateFormat(format).format(dt);
    return formattedTime;
  }

  static String formatAudioDuration(String durationInSeconds) {
    try {
      final seconds = double.tryParse(durationInSeconds);
      if (seconds == null || seconds < 0) return "00:00";

      final int totalSeconds = seconds.round();
      final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
      final secondsStr = (totalSeconds % 60).toString().padLeft(2, '0');
      return '$minutes:$secondsStr';
    } catch (e) {
      // You can also log this error if needed
      return "00:00";
    }
  }

  static void showSimpleAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
          title: CustomText(text: title),
          content: CustomText(text:message),
          actions: [
            TextButton(
              child: CustomText(text: getTranslated(context, AppStrings.close),color: AppColors.primaryColor),
              onPressed: () {
                Navigator.of(context).pop(); // Closes the dialog
              },
            ),
          ],
        );
      },
    );
  }

  static showAlertPopup(String text){
    var context = NavigationService.navigatorKey.currentState!.context;
    AppAlerts.showCustomPopupAlert(context: context, text: text, yesBtnText: getTranslated(context, AppStrings.ok), onTapConfirm: (){});
  }

}

enum LaunchType { phone, sms, email, url }
