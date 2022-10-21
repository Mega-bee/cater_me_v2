// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../http_client/http_client.dart' as _i9;
import '../main.dart' as _i66;
import '../module_addresses/address_module.dart' as _i65;
import '../module_addresses/repository/address_repository.dart' as _i27;
import '../module_addresses/state_manager/address_state_manager.dart' as _i52;
import '../module_addresses/ui/screens/address_screen.dart' as _i53;
import '../module_auth/authoriazation_module.dart' as _i54;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i11;
import '../module_auth/service/auth_service/auth_service.dart' as _i12;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i17;
import '../module_auth/state_manager/signup_state_manager.dart' as _i23;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i35;
import '../module_auth/ui/screen/singup_screen.dart' as _i24;
import '../module_credits/credit_module.dart' as _i56;
import '../module_credits/repository/credits_repository.dart' as _i14;
import '../module_credits/state_manager/credits_state_manager.dart' as _i29;
import '../module_credits/ui/screens/credits_screen.dart' as _i55;
import '../module_friends/friends_module.dart' as _i58;
import '../module_friends/repository/friends_repository.dart' as _i15;
import '../module_friends/state_manager/friends_state_manager.dart' as _i30;
import '../module_friends/ui/screens/friends_screen.dart' as _i31;
import '../module_friends/ui/screens/select_friends_screen.dart' as _i49;
import '../module_home/homepage_module.dart' as _i59;
import '../module_home/repository/homepage_repository.dart' as _i16;
import '../module_home/state_manager/homepage_state_manager.dart' as _i32;
import '../module_home/ui/screens/home_page_screen.dart' as _i33;
import '../module_home/ui/screens/item_detailes.dart' as _i34;
import '../module_home/ui/screens/package_item_list.dart' as _i43;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i5;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i6;
import '../module_notification/notification_module.dart' as _i60;
import '../module_notification/repository/noti_repository.dart' as _i18;
import '../module_notification/state_manager/notification_state_manager.dart'
    as _i36;
import '../module_notification/ui/screens/notifications_screen.dart' as _i37;
import '../module_occasions/occasions_module.dart' as _i61;
import '../module_occasions/repository/occasions_repository.dart' as _i19;
import '../module_occasions/state_manager/occasions_state_manager.dart' as _i38;
import '../module_occasions/ui/screens/occasions_screen.dart' as _i39;
import '../module_orders/order_module.dart' as _i62;
import '../module_orders/repository/orders_repository.dart' as _i20;
import '../module_orders/state_manager/orders_state_manager.dart' as _i40;
import '../module_orders/ui/screens/orders_detailes_screen.dart' as _i41;
import '../module_orders/ui/screens/orders_screen.dart' as _i42;
import '../module_payments/payment_module.dart' as _i46;
import '../module_payments/repository/payment_repository.dart' as _i21;
import '../module_payments/state_manager/payment_state_manager.dart' as _i44;
import '../module_payments/ui/screens/payment_method_screen.dart' as _i45;
import '../module_profile/profile_module.dart' as _i63;
import '../module_profile/repository/profile_repository.dart' as _i22;
import '../module_profile/state_manager/profile_state_manager.dart' as _i47;
import '../module_profile/ui/screen/edit_profile_screen.dart' as _i57;
import '../module_settings/repository/contactus_repository.dart' as _i13;
import '../module_settings/setting_module.dart' as _i64;
import '../module_settings/state_manager/contact_state_manager.dart' as _i28;
import '../module_settings/state_manager/survey_state_manager.dart' as _i26;
import '../module_settings/ui/screen/rating_screen.dart' as _i48;
import '../module_settings/ui/screen/setting_screen.dart' as _i50;
import '../module_splash/splash_module.dart' as _i51;
import '../module_splash/ui/screen/splash_screen.dart' as _i25;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i8;
import '../module_theme/service/theme_service/theme_service.dart' as _i10;
import '../utils/global/global_state_manager.dart' as _i4;
import '../utils/logger/logger.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.AuthPrefsHelper>(() => _i3.AuthPrefsHelper());
  gh.singleton<_i4.GlobalStateManager>(_i4.GlobalStateManager());
  gh.factory<_i5.LocalizationPreferencesHelper>(
      () => _i5.LocalizationPreferencesHelper());
  gh.factory<_i6.LocalizationService>(
      () => _i6.LocalizationService(get<_i5.LocalizationPreferencesHelper>()));
  gh.factory<_i7.Logger>(() => _i7.Logger());
  gh.factory<_i8.ThemePreferencesHelper>(() => _i8.ThemePreferencesHelper());
  gh.factory<_i9.ApiClient>(() => _i9.ApiClient(get<_i7.Logger>()));
  gh.factory<_i10.AppThemeDataService>(
      () => _i10.AppThemeDataService(get<_i8.ThemePreferencesHelper>()));
  gh.factory<_i11.AuthRepository>(() => _i11.AuthRepository(
        get<_i9.ApiClient>(),
        get<_i7.Logger>(),
      ));
  gh.factory<_i12.AuthService>(() => _i12.AuthService(
        get<_i3.AuthPrefsHelper>(),
        get<_i11.AuthRepository>(),
      ));
  gh.factory<_i13.ContactUsRepository>(() => _i13.ContactUsRepository(
        get<_i9.ApiClient>(),
        get<_i12.AuthService>(),
      ));
  gh.factory<_i14.CreditsRepository>(() => _i14.CreditsRepository(
        get<_i9.ApiClient>(),
        get<_i12.AuthService>(),
      ));
  gh.factory<_i15.FriendsRepository>(() => _i15.FriendsRepository(
        get<_i9.ApiClient>(),
        get<_i12.AuthService>(),
      ));
  gh.factory<_i16.HomePageRepository>(() => _i16.HomePageRepository(
        get<_i9.ApiClient>(),
        get<_i12.AuthService>(),
      ));
  gh.factory<_i17.LoginStateManager>(
      () => _i17.LoginStateManager(get<_i12.AuthService>()));
  gh.factory<_i18.NotificationRepository>(() => _i18.NotificationRepository(
        get<_i9.ApiClient>(),
        get<_i12.AuthService>(),
      ));
  gh.factory<_i19.OccasionsRepository>(() => _i19.OccasionsRepository(
        get<_i9.ApiClient>(),
        get<_i12.AuthService>(),
      ));
  gh.factory<_i20.OrdersRepository>(() => _i20.OrdersRepository(
        get<_i9.ApiClient>(),
        get<_i12.AuthService>(),
      ));
  gh.factory<_i21.PaymentRepository>(() => _i21.PaymentRepository(
        get<_i9.ApiClient>(),
        get<_i12.AuthService>(),
      ));
  gh.factory<_i22.ProfileRepository>(() => _i22.ProfileRepository(
        get<_i9.ApiClient>(),
        get<_i12.AuthService>(),
      ));
  gh.factory<_i23.SignUpStateManager>(
      () => _i23.SignUpStateManager(get<_i12.AuthService>()));
  gh.factory<_i24.SingUpScreen>(
      () => _i24.SingUpScreen(get<_i23.SignUpStateManager>()));
  gh.factory<_i25.SplashScreen>(
      () => _i25.SplashScreen(get<_i12.AuthService>()));
  gh.factory<_i26.SurveyCubit>(
      () => _i26.SurveyCubit(get<_i13.ContactUsRepository>()));
  gh.factory<_i27.AddressRepository>(() => _i27.AddressRepository(
        get<_i9.ApiClient>(),
        get<_i12.AuthService>(),
      ));
  gh.factory<_i28.ContactCubit>(
      () => _i28.ContactCubit(get<_i13.ContactUsRepository>()));
  gh.factory<_i29.CreditsCubit>(
      () => _i29.CreditsCubit(get<_i14.CreditsRepository>()));
  gh.factory<_i30.FriendsCubit>(
      () => _i30.FriendsCubit(get<_i15.FriendsRepository>()));
  gh.factory<_i31.FriendsScreen>(
      () => _i31.FriendsScreen(get<_i30.FriendsCubit>()));
  gh.factory<_i32.HomePageCubit>(() => _i32.HomePageCubit(
        get<_i16.HomePageRepository>(),
        get<_i6.LocalizationService>(),
      ));
  gh.factory<_i33.HomePageScreen>(
      () => _i33.HomePageScreen(get<_i32.HomePageCubit>()));
  gh.factory<_i34.ItemDetailsScreen>(() => _i34.ItemDetailsScreen(
        get<_i32.HomePageCubit>(),
        get<_i12.AuthService>(),
      ));
  gh.factory<_i35.LoginScreen>(
      () => _i35.LoginScreen(get<_i17.LoginStateManager>()));
  gh.factory<_i36.NotificationCubit>(
      () => _i36.NotificationCubit(get<_i18.NotificationRepository>()));
  gh.factory<_i37.NotificationsScreen>(
      () => _i37.NotificationsScreen(get<_i36.NotificationCubit>()));
  gh.factory<_i38.OccasionsCubit>(
      () => _i38.OccasionsCubit(get<_i19.OccasionsRepository>()));
  gh.factory<_i39.OccasionsScreen>(
      () => _i39.OccasionsScreen(get<_i38.OccasionsCubit>()));
  gh.factory<_i40.OrdersCubit>(
      () => _i40.OrdersCubit(get<_i20.OrdersRepository>()));
  gh.factory<_i41.OrdersDetailsScreen>(
      () => _i41.OrdersDetailsScreen(get<_i40.OrdersCubit>()));
  gh.factory<_i42.OrdersScreen>(
      () => _i42.OrdersScreen(get<_i40.OrdersCubit>()));
  gh.factory<_i43.PackagesItemsListScreen>(() => _i43.PackagesItemsListScreen(
        get<_i32.HomePageCubit>(),
        get<_i12.AuthService>(),
      ));
  gh.factory<_i44.PaymentCubit>(() => _i44.PaymentCubit(
        get<_i21.PaymentRepository>(),
        get<_i14.CreditsRepository>(),
      ));
  gh.factory<_i45.PaymentMethodScreen>(
      () => _i45.PaymentMethodScreen(get<_i44.PaymentCubit>()));
  gh.factory<_i46.PaymentModule>(
      () => _i46.PaymentModule(get<_i45.PaymentMethodScreen>()));
  gh.factory<_i47.ProfileCubit>(
      () => _i47.ProfileCubit(get<_i22.ProfileRepository>()));
  gh.factory<_i48.RatingScreen>(
      () => _i48.RatingScreen(cubit: get<_i26.SurveyCubit>()));
  gh.factory<_i49.SelectFriendsScreen>(
      () => _i49.SelectFriendsScreen(get<_i30.FriendsCubit>()));
  gh.factory<_i50.SettingScreen>(() => _i50.SettingScreen(
        get<_i12.AuthService>(),
        get<_i6.LocalizationService>(),
        get<_i10.AppThemeDataService>(),
        get<_i28.ContactCubit>(),
      ));
  gh.factory<_i51.SplashModule>(
      () => _i51.SplashModule(get<_i25.SplashScreen>()));
  gh.factory<_i52.AddressCubit>(
      () => _i52.AddressCubit(get<_i27.AddressRepository>()));
  gh.factory<_i53.AddressScreen>(
      () => _i53.AddressScreen(get<_i52.AddressCubit>()));
  gh.factory<_i54.AuthorizationModule>(() => _i54.AuthorizationModule(
        get<_i35.LoginScreen>(),
        get<_i24.SingUpScreen>(),
      ));
  gh.factory<_i55.CreditScreen>(
      () => _i55.CreditScreen(get<_i29.CreditsCubit>()));
  gh.factory<_i56.CreditsModule>(
      () => _i56.CreditsModule(get<_i55.CreditScreen>()));
  gh.factory<_i57.EditProfileScreen>(
      () => _i57.EditProfileScreen(get<_i47.ProfileCubit>()));
  gh.factory<_i58.FriendsModule>(() => _i58.FriendsModule(
        get<_i31.FriendsScreen>(),
        get<_i49.SelectFriendsScreen>(),
      ));
  gh.factory<_i59.HomePageModule>(() => _i59.HomePageModule(
        get<_i33.HomePageScreen>(),
        get<_i43.PackagesItemsListScreen>(),
        get<_i34.ItemDetailsScreen>(),
      ));
  gh.factory<_i60.NotificationModule>(
      () => _i60.NotificationModule(get<_i37.NotificationsScreen>()));
  gh.factory<_i61.OccasionsModule>(
      () => _i61.OccasionsModule(get<_i39.OccasionsScreen>()));
  gh.factory<_i62.OrdersModule>(() => _i62.OrdersModule(
        get<_i42.OrdersScreen>(),
        get<_i41.OrdersDetailsScreen>(),
      ));
  gh.factory<_i63.ProfileModule>(
      () => _i63.ProfileModule(get<_i57.EditProfileScreen>()));
  gh.factory<_i64.SettingModule>(() => _i64.SettingModule(
        get<_i48.RatingScreen>(),
        get<_i50.SettingScreen>(),
      ));
  gh.factory<_i65.AddressModule>(
      () => _i65.AddressModule(get<_i53.AddressScreen>()));
  gh.factory<_i66.MyApp>(() => _i66.MyApp(
        get<_i10.AppThemeDataService>(),
        get<_i6.LocalizationService>(),
        get<_i51.SplashModule>(),
        get<_i54.AuthorizationModule>(),
        get<_i59.HomePageModule>(),
        get<_i61.OccasionsModule>(),
        get<_i64.SettingModule>(),
        get<_i58.FriendsModule>(),
        get<_i63.ProfileModule>(),
        get<_i56.CreditsModule>(),
        get<_i46.PaymentModule>(),
        get<_i65.AddressModule>(),
        get<_i62.OrdersModule>(),
        get<_i60.NotificationModule>(),
      ));
  return get;
}
