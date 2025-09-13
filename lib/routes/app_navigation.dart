import 'package:car_wash_app/models/order_model.dart';
import 'package:car_wash_app/models/service_detail_model.dart';
import 'package:car_wash_app/models/services_model.dart';
import 'package:car_wash_app/views/services/service_detail_screen.dart';
import 'package:car_wash_app/views/services/services_screen.dart';
import 'package:flutter/material.dart';

import '../models/car_model.dart';
import '../views/allow_notification_screen/allow_notification_screen.dart';
import '../views/auth_screens/login_screen.dart';
import '../views/auth_screens/otp_verify_screen.dart';
import '../views/auth_screens/signup_screen.dart';
import '../views/auth_screens/update_password_screen.dart';
import '../views/car_detail/car_detail_screen.dart';
import '../views/custom_image_viewer_screen.dart';
import '../views/dashboard/dashboard_screen.dart';
import '../views/location_screen/location_allow_screen.dart';
import '../views/location_screen/manually_location_enter_screen.dart';
import '../views/messages/messages_screen.dart';
import '../views/my_cars/cars_listing_screen.dart';
import '../views/onboarding_screens/onboarding_screen.dart';
import '../views/onboarding_screens/welcome_screen.dart';
import '../views/orders/my_orders_screen.dart';
import '../views/orders/order_detail_screen.dart';
import '../views/profile/views/manage_address.dart';
import '../views/profile/views/your_profile.dart';
import '../views/profile_screens/complete_your_profile_screen.dart';
import '../views/searched_cars/searched_cars_screen.dart';
import '../views/services/book_service_screen.dart';

class AppNavigation{
  static void navigateToWelcomeScreen(BuildContext context){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const WelcomeScreen()), (Route<dynamic> route) => false);
  }
  static void navigateToOnboardingScreen(BuildContext context){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  const OnboardingScreen()));
  }

  static void navigateToLoginScreen(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const LoginScreen()));
  }
  static void navigateToSignupScreen(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const SignupScreen()));
  }
  static void navigateToOtpVerifyScreen(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const OtpVerifyScreen()));
  }
  static void navigateToUpdatePasswordScreen(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const UpdatePasswordScreen()));
  }
  static void navigateToCompleteYourProfileScreen(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const CompleteYourProfileScreen()));
  }
  static void navigateToLocationAllowScreen(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const LocationAllowScreen()));
  }
  static void navigateToManuallyLocationEnterScreen(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const ManuallyLocationEnterScreen()));
  }
  static void navigateToAllowNotificationScreen(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const AllowNotificationScreen()));
  }
  // static void navigateToSignUpQuestionsScreen(BuildContext context){
  //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  const SignUpFormQuestionsScreen()));
  // }
  // static void navigateToUserRegistrationScreen(BuildContext context){
  //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  const UserRegistrationScreen()));
  // }
  // static void navigateToQuestionnaireScreen(BuildContext context){
  //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  const QuestionnaireScreen()));
  // }
  // static void navigateToProgressRecordScreen(BuildContext context){
  //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  const ProgressRecordScreen()));
  // }
  // static void navigateToProgressPhotoDocumentScreen(BuildContext context,{int selectedIndex = 0}){
  //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProgressPhotoDocumentScreen(selectedIndex: selectedIndex)));
  // }
  static void navigateToDashboardScreen(BuildContext context){
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const DashboardScreen()), (Route<dynamic> route) => false);
  }
  static void navigateToServiceDetailScreen(BuildContext context,CarsModel obj){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  CarDetailScreen(obj: obj)));
  }
  static void navigateToCartScreen(BuildContext context){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  MessagesScreen()));
  }
  static void navigateToYourProfile(BuildContext context){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  YourProfile()));
  }
  static void navigateToManageAddress(BuildContext context){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  ManageAddresses()));
  }
  static void navigateToCustomImageViewer(BuildContext context,{required List<String> urls,int index = 0}){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  CustomImageViewer(imagesList: urls,startIndex: index,)));
  }
  static void navigateToSearchedItemsScreen(BuildContext context){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  SearchedCarsScreen()));
  }
  static void navigateToServicesScreen(BuildContext context,{bool hasFilters = false}){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  ServicesScreen(isAlreadyHavingFilters: hasFilters)));
  }
  static void navigateToServiceDetailsScreen(BuildContext context,ServiceModel serviceId){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  ServiceDetailScreen(obj: serviceId)));
  }
  static void navigateToBookServiceScreen(BuildContext context,ServiceDetailModel obj){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  BookServiceScreen(service: obj)));
  }
  static void navigateToOrdersListScreen(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  OrdersListScreen()));
  }
  static void navigateToCarListingsScreen(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyCarsScreen()));
  }
  static void navigateToOrderDetailScreen(BuildContext context,OrderModel order){
    Navigator.push(context, MaterialPageRoute(builder: (context) =>  OrderDetailScreen(order: order)));
  }
  //
  // static void navigateToCustomImageViewer(BuildContext context,List<String> imagesList){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  CustomImageViewer(imagesList: imagesList)));
  // }
  // // static void navigateToProgramsScreen(BuildContext context){
  // //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  const ProgramsScreen()));
  // // }
  // static void navigateToProgramDetailScreen(BuildContext context,TodayExercises obj){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=> ProgramDetailScreen(obj:obj)));
  // }
  // // static void navigateToNutritionDetailScreen(BuildContext context){
  // //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  const NutritionDetailScreen()));
  // // }
  //
  // static void navigateToTrainingScreen(BuildContext context,{int selectedIndex = 0 }){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  TrainingProgramScreen(selectedIndex: selectedIndex)));
  // }
  // static void navigateToChatMessageScreen(BuildContext context,ChatListingModel obj){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  ChatMessageScreen(chatListingModel:obj)));
  // }
  // static void navigateToPersonalInformationScreen(BuildContext context){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  const PersonalInformationScreen()));
  // }
  // static void navigateToManageSubscriptionScreen(BuildContext context){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  const ManageSubscriptionScreen()));
  // }
  // static void navigateToProfileSettingScreen(BuildContext context){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  const ProfileSettingScreen()));
  // }
  // static void navigateToHelpScreen(BuildContext context){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  const HelpScreen()));
  // }
  // static void navigateToContactSupportScreen(BuildContext context){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  const ContactSupportScreen()));
  // }
  // static void navigateToPrivacyPolicyScreen(BuildContext context){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  const PrivacyPolicyScreen()));
  // }
  // static void navigateToFaqsScreen(BuildContext context){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  const FaqsScreen()));
  // }
  // static void navigateToReadyToChangeScreen(BuildContext context){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  const ReadyToChangeScreen()));
  // }
  // static void navigateToRequestDeniedScreen(BuildContext context){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  const RequestDeniedScreen()));
  // }
  // static void navigateToClientProfileScreen(BuildContext context, User user){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  ClientProfileScreen(user:user)));
  // }
  // // static void navigateToTrainerPayScreen(BuildContext context){
  // //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  const TrainerPayScreen()));
  // // }
  // static void navigateToPaymentSuccessScreen(BuildContext context){
  //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const PaymentSuccessScreen()), (Route<dynamic> route) => false);
  //   // Navigator.push(context, MaterialPageRoute(builder: (context)=>  const PaymentSuccessScreen()));
  // }
  // static void navigateToPaymentFailedScreen(BuildContext context){
  //   // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const PaymentFailedScreen()), (Route<dynamic> route) => false);
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  const PaymentFailedScreen()));
  // }
  // static void navigateToPaymentDetailScreen(BuildContext context){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  const PaymentDetailScreen()));
  // }
  // static void navigateToPaymentMethodScreen(BuildContext context){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  const PaymentMethodScreen()));
  // }
  // static void navigateToPayScreen(BuildContext context){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  const PayScreen()));
  // }
  // static void navigateToAnnouncementDetailScreen(BuildContext context){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  const AnnouncementDetailScreen()));
  // }
  // static void navigateToClientWelcomeScreen(BuildContext context){
  //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const RequestWelcomeScreen()), (Route<dynamic> route) => false);
  // }
  // static void navigateToClientPendingRequest(BuildContext context){
  //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ClientPendingRequest()), (Route<dynamic> route) => false);
  // }
  // static void navigateToClientRequestApprovedScreen(BuildContext context){
  //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ClientRequestApprovedScreen()), (Route<dynamic> route) => false);
  // }
  // static void navigateToOnboardingScreen(BuildContext context){
  //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  OnboardingScreen()));
  // }


}