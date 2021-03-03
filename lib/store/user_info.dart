class UserInfo{
  static int userId;
  static String userName;
  static int userType;
  static setInfo(userId, userName, userType){
    UserInfo.userId = userId;
    UserInfo.userName = userName;
    UserInfo.userType = userType;
  }
}