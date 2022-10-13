class Urls {

  static const String DOMAIN = 'https://cater-me.azurewebsites.net/api/';
  static const String BASE_API = DOMAIN + '';

  static const String ACCOUNTS = DOMAIN + 'Accounts/';
  static const String OCCASIONS = DOMAIN + 'Occasions/';
  static const String FRIENDS = DOMAIN + 'Friends/';

  //-------------Auth------------
  static const String LOGIN = ACCOUNTS + 'Login';

//-----------Home-----------
  static const String GET_HOME_PAGE = DOMAIN + 'HomePage/GetHomePage';

  //-----------OCCASIONS-----------
  static const String GET_OCCASIONS = OCCASIONS + 'GetAllOccasions';
  static const String CREATE_OCCASION = OCCASIONS + 'CreateOccasion';
  static const String UPDATE_OCCASION = OCCASIONS + 'UpdateOccasion';
  static const String DELETE_OCCASION = OCCASIONS + 'DeleteOccasion/';


  //-----------FRIENDS-----------
  static const String GET_FRIENDS = FRIENDS + 'GetAllFriends';
  static const String CREATE_FRIEND = FRIENDS + 'CreateFriend';
  static const String UPDATE_FRIEND = FRIENDS + 'UpdateFriend';
  static const String DELETE_FRIEND = FRIENDS + 'DeleteFriend/';
}
