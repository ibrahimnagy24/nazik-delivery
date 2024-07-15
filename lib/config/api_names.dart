abstract class ApiNames {
  static const login = "login";
  static const forgetPassword = "forgot/password";
  static const resend = "resend/code";
  static const otp = "check/code";
  static const resetPassword = "reset/password";
  static const changePassword = "edit/password";

  ///Profile
  static const profile = "profile";
  static const editProfile = "edit/profile";

  ///Requests
  static const requests = "orders";
  static requestDetails(id) => "orders/$id";
  static assignRequest(id) => "orders/$id/assign-to-delivery-employee";
  static unAssignRequest(id) => "orders/$id/un-assign-to-delivery-employee";
  static updateRequestStatus(id) => "update-order-status/$id";

  ///Notifications
  static const notifications = "notifications";
  static readNotifications(id) => "notifications/read/$id";

  ///Static Pages
  static const policy = "policy";
  static const terms = "terms";

  ///Log Out
  static const logout = "logout";
}
