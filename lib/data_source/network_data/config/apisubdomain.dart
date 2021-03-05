class API {
  static const String domain = 'domain.com';
  //- fcm
  static const String updateFCM = "/mobile/device";
  //- authen
  static const String registerUser = "/mobile/register";
  static const String updateProfileSocial = "/mobile/login/profile";
  static const String verifiedUser = "/mobile/verified";
  static const String login = "/mobile/login";
  static const String loginGoogle = "/mobile/login/google";
  static const String loginFacbook = "/mobile/login/facebook";
  static const String forgetPassword = "/mobile/forget-password";
  static const String changePassword = "/mobile/change-password";
  static const String otpChangePassword = "/mobile/otp-change-password";
  //- profile
  static const String profile = "/mobile/profile";
  static const String updateProfile = "/mobile/profile";
  //- notification
  static const String listNotification = "/mobile/notification";
  //- voucher
  static const String listVoucher = "/mobile/voucher";
  //- order
  static const String listOrder = "/mobile/order";
  //- event
  static const String listEvent = "/mobile/event";
  static const String eventDetail = "/mobile/event/detail";
  static const String joinEvent = "/mobile/event/join";
  static const String cancelEvent = "/mobile/event/canceled";
  //- news
  static const String categorNews = "/mobile/news/category";
  static const String listNews = "/mobile/news";
  static const String newsDetail = "/mobile/news/detail";
  static const String listNewsHighlight = "/mobile/news/highlight";
  //- contact
  static const String listContact = "/mobile/contact";
  static const String chatAdmin = "/mobile/chat";
  static const String uploadFileChat = "/mobile/chat/images";

  //- product
  static const String categoryProduct = "/mobile/product/category";
  static const String listProduct = "/mobile/product";
  static const String listHighlightProduct = "/mobile/product";
  static const String productDetail = "/mobile/product/detail";
  static const String order = "/mobile/order";
  static const String checkVoucher = "/mobile/voucher/check";
}
