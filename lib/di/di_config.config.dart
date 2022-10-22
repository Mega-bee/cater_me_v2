// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../http_client/http_client.dart' as _i10;
import '../main.dart' as _i67;
import '../module_addresses/address_module.dart' as _i66;
import '../module_addresses/repository/address_repository.dart' as _i28;
import '../module_addresses/state_manager/address_state_manager.dart' as _i53;
import '../module_addresses/ui/screens/address_screen.dart' as _i54;
import '../module_auth/authoriazation_module.dart' as _i55;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i12;
import '../module_auth/service/auth_service/auth_service.dart' as _i13;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i18;
import '../module_auth/state_manager/signup_state_manager.dart' as _i24;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i36;
import '../module_auth/ui/screen/singup_screen.dart' as _i25;
import '../module_auth/ui/screen/terms_and_conditions.dart' as _i8;
import '../module_credits/credit_module.dart' as _i57;
import '../module_credits/repository/credits_repository.dart' as _i15;
import '../module_credits/state_manager/credits_state_manager.dart' as _i30;
import '../module_credits/ui/screens/credits_screen.dart' as _i56;
import '../module_friends/friends_module.dart' as _i59;
import '../module_friends/repository/friends_repository.dart' as _i16;
import '../module_friends/state_manager/friends_state_manager.dart' as _i31;
import '../module_friends/ui/screens/friends_screen.dart' as _i32;
import '../module_friends/ui/screens/select_friends_screen.dart' as _i50;
import '../module_home/homepage_module.dart' as _i60;
import '../module_home/repository/homepage_repository.dart' as _i17;
import '../module_home/state_manager/homepage_state_manager.dart' as _i33;
import '../module_home/ui/screens/home_page_screen.dart' as _i34;
import '../module_home/ui/screens/item_detailes.dart' as _i35;
import '../module_home/ui/screens/package_item_list.dart' as _i44;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i5;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i6;
import '../module_notification/notification_module.dart' as _i61;
import '../module_notification/repository/noti_repository.dart' as _i19;
import '../module_notification/state_manager/notification_state_manager.dart'
    as _i37;
import '../module_notification/ui/screens/notifications_screen.dart' as _i38;
import '../module_occasions/occasions_module.dart' as _i62;
import '../module_occasions/repository/occasions_repository.dart' as _i20;
import '../module_occasions/state_manager/occasions_state_manager.dart' as _i39;
import '../module_occasions/ui/screens/occasions_screen.dart' as _i40;
import '../module_orders/order_module.dart' as _i63;
import '../module_orders/repository/orders_repository.dart' as _i21;
import '../module_orders/state_manager/orders_state_manager.dart' as _i41;
import '../module_orders/ui/screens/orders_detailes_screen.dart' as _i42;
import '../module_orders/ui/screens/orders_screen.dart' as _i43;
import '../module_payments/payment_module.dart' as _i47;
import '../module_payments/repository/payment_repository.dart' as _i22;
import '../module_payments/state_manager/payment_state_manager.dart' as _i45;
import '../module_payments/ui/screens/payment_method_screen.dart' as _i46;
import '../module_profile/profile_module.dart' as _i64;
import '../module_profile/repository/profile_repository.dart' as _i23;
import '../module_profile/state_manager/profile_state_manager.dart' as _i48;
import '../module_profile/ui/screen/edit_profile_screen.dart' as _i58;
import '../module_settings/repository/contactus_repository.dart' as _i14;
import '../module_settings/setting_module.dart' as _i65;
import '../module_settings/state_manager/contact_state_manager.dart' as _i29;
import '../module_settings/state_manager/survey_state_manager.dart' as _i27;
import '../module_settings/ui/screen/rating_screen.dart' as _i49;
import '../module_settings/ui/screen/setting_screen.dart' as _i51;
import '../module_splash/splash_module.dart' as _i52;
import '../module_splash/ui/screen/splash_screen.dart' as _i26;
import '../module_theme/pressistance/theme_preferences_helper.dart' as _i9;
import '../module_theme/service/theme_service/theme_service.dart' as _i11;
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
  gh.factory<_i8.TermsAndConditions>(() => _i8.TermsAndConditions());
  gh.factory<_i9.ThemePreferencesHelper>(() => _i9.ThemePreferencesHelper());
  gh.factory<_i10.ApiClient>(() => _i10.ApiClient(get<_i7.Logger>()));
  gh.factory<_i11.AppThemeDataService>(
      () => _i11.AppThemeDataService(get<_i9.ThemePreferencesHelper>()));
  gh.factory<_i12.AuthRepository>(() => _i12.AuthRepository(
        get<_i10.ApiClient>(),
        get<_i7.Logger>(),
      ));
  gh.factory<_i13.AuthService>(() => _i13.AuthService(
        get<_i3.AuthPrefsHelper>(),
        get<_i12.AuthRepository>(),
      ));
  gh.factory<_i14.ContactUsRepository>(() => _i14.ContactUsRepository(
        get<_i10.ApiClient>(),
        get<_i13.AuthService>(),
      ));
  gh.factory<_i15.CreditsRepository>(() => _i15.CreditsRepository(
        get<_i10.ApiClient>(),
        get<_i13.AuthService>(),
      ));
  gh.factory<_i16.FriendsRepository>(() => _i16.FriendsRepository(
        get<_i10.ApiClient>(),
        get<_i13.AuthService>(),
      ));
  gh.factory<_i17.HomePageRepository>(() => _i17.HomePageRepository(
        get<_i10.ApiClient>(),
        get<_i13.AuthService>(),
      ));
  gh.factory<_i18.LoginStateManager>(
      () => _i18.LoginStateManager(get<_i13.AuthService>()));
  gh.factory<_i19.NotificationRepository>(() => _i19.NotificationRepository(
        get<_i10.ApiClient>(),
        get<_i13.AuthService>(),
      ));
  gh.factory<_i20.OccasionsRepository>(() => _i20.OccasionsRepository(
        get<_i10.ApiClient>(),
        get<_i13.AuthService>(),
      ));
  gh.factory<_i21.OrdersRepository>(() => _i21.OrdersRepository(
        get<_i10.ApiClient>(),
        get<_i13.AuthService>(),
      ));
  gh.factory<_i22.PaymentRepository>(() => _i22.PaymentRepository(
        get<_i10.ApiClient>(),
        get<_i13.AuthService>(),
      ));
  gh.factory<_i23.ProfileRepository>(() => _i23.ProfileRepository(
        get<_i10.ApiClient>(),
        get<_i13.AuthService>(),
      ));
  gh.factory<_i24.SignUpStateManager>(
      () => _i24.SignUpStateManager(get<_i13.AuthService>()));
  gh.factory<_i25.SingUpScreen>(
      () => _i25.SingUpScreen(get<_i24.SignUpStateManager>()));
  gh.factory<_i26.SplashScreen>(
      () => _i26.SplashScreen(get<_i13.AuthService>()));
  gh.factory<_i27.SurveyCubit>(
      () => _i27.SurveyCubit(get<_i14.ContactUsRepository>()));
  gh.factory<_i28.AddressRepository>(() => _i28.AddressRepository(
        get<_i10.ApiClient>(),
        get<_i13.AuthService>(),
      ));
  gh.factory<_i29.ContactCubit>(
      () => _i29.ContactCubit(get<_i14.ContactUsRepository>()));
  gh.factory<_i30.CreditsCubit>(
      () => _i30.CreditsCubit(get<_i15.CreditsRepository>()));
  gh.factory<_i31.FriendsCubit>(
      () => _i31.FriendsCubit(get<_i16.FriendsRepository>()));
  gh.factory<_i32.FriendsScreen>(
      () => _i32.FriendsScreen(get<_i31.FriendsCubit>()));
  gh.factory<_i33.HomePageCubit>(() => _i33.HomePageCubit(
        get<_i17.HomePageRepository>(),
        get<_i6.LocalizationService>(),
      ));
  gh.factory<_i34.HomePageScreen>(
      () => _i34.HomePageScreen(get<_i33.HomePageCubit>()));
  gh.factory<_i35.ItemDetailsScreen>(() => _i35.ItemDetailsScreen(
        get<_i33.HomePageCubit>(),
        get<_i13.AuthService>(),
      ));
  gh.factory<_i36.LoginScreen>(
      () => _i36.LoginScreen(get<_i18.LoginStateManager>()));
  gh.factory<_i37.NotificationCubit>(
      () => _i37.NotificationCubit(get<_i19.NotificationRepository>()));
  gh.factory<_i38.NotificationsScreen>(
      () => _i38.NotificationsScreen(get<_i37.NotificationCubit>()));
  gh.factory<_i39.OccasionsCubit>(
      () => _i39.OccasionsCubit(get<_i20.OccasionsRepository>()));
  gh.factory<_i40.OccasionsScreen>(
      () => _i40.OccasionsScreen(get<_i39.OccasionsCubit>()));
  gh.factory<_i41.OrdersCubit>(
      () => _i41.OrdersCubit(get<_i21.OrdersRepository>()));
  gh.factory<_i42.OrdersDetailsScreen>(
      () => _i42.OrdersDetailsScreen(get<_i41.OrdersCubit>()));
  gh.factory<_i43.OrdersScreen>(
      () => _i43.OrdersScreen(get<_i41.OrdersCubit>()));
  gh.factory<_i44.PackagesItemsListScreen>(() => _i44.PackagesItemsListScreen(
        get<_i33.HomePageCubit>(),
        get<_i13.AuthService>(),
      ));
  gh.factory<_i45.PaymentCubit>(() => _i45.PaymentCubit(
        get<_i22.PaymentRepository>(),
        get<_i15.CreditsRepository>(),
      ));
  gh.factory<_i46.PaymentMethodScreen>(
      () => _i46.PaymentMethodScreen(get<_i45.PaymentCubit>()));
  gh.factory<_i47.PaymentModule>(
      () => _i47.PaymentModule(get<_i46.PaymentMethodScreen>()));
  gh.factory<_i48.ProfileCubit>(
      () => _i48.ProfileCubit(get<_i23.ProfileRepository>()));
  gh.factory<_i49.RatingScreen>(
      () => _i49.RatingScreen(cubit: get<_i27.SurveyCubit>()));
  gh.factory<_i50.SelectFriendsScreen>(
      () => _i50.SelectFriendsScreen(get<_i31.FriendsCubit>()));
  gh.factory<_i51.SettingScreen>(() => _i51.SettingScreen(
        get<_i13.AuthService>(),
        get<_i6.LocalizationService>(),
        get<_i11.AppThemeDataService>(),
        get<_i29.ContactCubit>(),
      ));
  gh.factory<_i52.SplashModule>(
      () => _i52.SplashModule(get<_i26.SplashScreen>()));
  gh.factory<_i53.AddressCubit>(
      () => _i53.AddressCubit(get<_i28.AddressRepository>()));
  gh.factory<_i54.AddressScreen>(
      () => _i54.AddressScreen(get<_i53.AddressCubit>()));
  gh.factory<_i55.AuthorizationModule>(() => _i55.AuthorizationModule(
        get<_i36.LoginScreen>(),
        get<_i25.SingUpScreen>(),
        get<_i8.TermsAndConditions>(),
      ));
  gh.factory<_i56.CreditScreen>(
      () => _i56.CreditScreen(get<_i30.CreditsCubit>()));
  gh.factory<_i57.CreditsModule>(
      () => _i57.CreditsModule(get<_i56.CreditScreen>()));
  gh.factory<_i58.EditProfileScreen>(
      () => _i58.EditProfileScreen(get<_i48.ProfileCubit>()));
  gh.factory<_i59.FriendsModule>(() => _i59.FriendsModule(
        get<_i32.FriendsScreen>(),
        get<_i50.SelectFriendsScreen>(),
      ));
  gh.factory<_i60.HomePageModule>(() => _i60.HomePageModule(
        get<_i34.HomePageScreen>(),
        get<_i44.PackagesItemsListScreen>(),
        get<_i35.ItemDetailsScreen>(),
      ));
  gh.factory<_i61.NotificationModule>(
      () => _i61.NotificationModule(get<_i38.NotificationsScreen>()));
  gh.factory<_i62.OccasionsModule>(
      () => _i62.OccasionsModule(get<_i40.OccasionsScreen>()));
  gh.factory<_i63.OrdersModule>(() => _i63.OrdersModule(
        get<_i43.OrdersScreen>(),
        get<_i42.OrdersDetailsScreen>(),
      ));
  gh.factory<_i64.ProfileModule>(
      () => _i64.ProfileModule(get<_i58.EditProfileScreen>()));
  gh.factory<_i65.SettingModule>(() => _i65.SettingModule(
        get<_i49.RatingScreen>(),
        get<_i51.SettingScreen>(),
      ));
  gh.factory<_i66.AddressModule>(
      () => _i66.AddressModule(get<_i54.AddressScreen>()));
  gh.factory<_i67.MyApp>(() => _i67.MyApp(
        get<_i11.AppThemeDataService>(),
        get<_i6.LocalizationService>(),
        get<_i52.SplashModule>(),
        get<_i55.AuthorizationModule>(),
        get<_i60.HomePageModule>(),
        get<_i62.OccasionsModule>(),
        get<_i65.SettingModule>(),
        get<_i59.FriendsModule>(),
        get<_i64.ProfileModule>(),
        get<_i57.CreditsModule>(),
        get<_i47.PaymentModule>(),
        get<_i66.AddressModule>(),
        get<_i63.OrdersModule>(),
        get<_i61.NotificationModule>(),
      ));
  return get;
}
