class ApiEndpoint{
  static String baseUrl = 'http://144.91.76.33:3002/api/v1/';
  static String imageBaseUrl = 'http://144.91.76.33:3002/';
  static String login =  'auth/customer/login';
  static String verifyOtp =  'auth/otp/verify';
  static String profile =  'user/get-profile';
  static String updateProfile =  'user/update-profile';
  static String deleteAccount =  'user/update-profile';
  static String getCities =  'city/get-cities';
  static String getCategories =  'category/get-categories';
  static String carsSearch =  'cars/search';
  static String cars =  'cars';
  static String businessServices =  'business/services';
  static String attachmentsUpload =  'attachments/upload';
  static String carsMakes =  'cars/makes';
  static String serviceSearch =  'services/search';
  static String services =  'services';
  static String customerOrders =  'customer/orders';
  static String customerCars =  'customer/cars';

  ///customer car register endpoints
  static String basic =  'basic';
  static String details =  'details';
  static String features =  'features';
  static String documents =  'documents';
  static String pricing =  'pricing';
  ///api/v1/customer/cars/basic
  ////api/v1/customer/cars/{id}/details
  ///api/v1/customer/cars/{id}/features
  ////api/v1/customer/cars/{id}/documents
  ///api/v1/customer/cars/{id}/pricing

  static String register =  'register';
  static String logout =  'logout';



  ///keys
  static String googleKey =  'AIzaSyCvM2zsGo54ZCwNO5i63qtSnNjCthq1C7c';

}