abstract class ApiNames {
  static const login = "login";
  static const forgetPassword = "forgot/password";
  static const resend = "resend/code";
  static const otp = "check/code";
  static const resetPassword = "reset/password";
  static const changePassword = "change/password";

  ///Profile
  static const profile = "profile";
  static const editProfile = "profile/edit";
  ///Requests
  static const requests = "requests";
  static const purchase = "purchase";
  static const deleteItem = "delete/item";


  ///Notifications
  static const notifications = "notifications";
  static readNotifications(id) => "notifications/read/$id";


  ///Static Pages
  static const policy = "policy";
  static const terms = "terms";
  ///Log Out
  static const logout = "logout";

}
