// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../http_client/http_client.dart' as _i9;
import '../main.dart' as _i34;
import '../module_auth/authoriazation_module.dart' as _i30;
import '../module_auth/presistance/auth_prefs_helper.dart' as _i3;
import '../module_auth/repository/auth/auth_repository.dart' as _i11;
import '../module_auth/service/auth_service/auth_service.dart' as _i12;
import '../module_auth/state_manager/login_state_manager/login_state_manager.dart'
    as _i15;
import '../module_auth/ui/screen/login_screen/login_screen.dart' as _i24;
import '../module_friends/friends_module.dart' as _i31;
import '../module_friends/repository/friends_repository.dart' as _i13;
import '../module_friends/state_manager/friends_state_manager.dart' as _i19;
import '../module_friends/ui/screens/friends_screen.dart' as _i20;
import '../module_home/homepage_module.dart' as _i32;
import '../module_home/repository/homepage_repository.dart' as _i14;
import '../module_home/state_manager/homepage_state_manager.dart' as _i21;
import '../module_home/ui/screens/home_page_screen.dart' as _i22;
import '../module_home/ui/screens/item_detailes.dart' as _i23;
import '../module_home/ui/screens/package_item_list.dart' as _i27;
import '../module_localization/presistance/localization_preferences_helper/localization_preferences_helper.dart'
    as _i5;
import '../module_localization/service/localization_service/localization_service.dart'
    as _i6;
import '../module_occasions/occasions_module.dart' as _i33;
import '../module_occasions/repository/occasions_repository.dart' as _i16;
import '../module_occasions/state_manager/occasions_state_manager.dart' as _i25;
import '../module_occasions/ui/screens/occasions_screen.dart' as _i26;
import '../module_settings/setting_module.dart' as _i28;
import '../module_settings/ui/screen/setting_screen.dart' as _i17;
import '../module_splash/splash_module.dart' as _i29;
import '../module_splash/ui/screen/splash_screen.dart' as _i18;
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
  gh.factory<_i13.FriendsRepository>(() => _i13.FriendsRepository(
        get<_i9.ApiClient>(),
        get<_i12.AuthService>(),
      ));
  gh.factory<_i14.HomePageRepository>(() => _i14.HomePageRepository(
        get<_i9.ApiClient>(),
        get<_i12.AuthService>(),
      ));
  gh.factory<_i15.LoginStateManager>(
      () => _i15.LoginStateManager(get<_i12.AuthService>()));
  gh.factory<_i16.OccasionsRepository>(() => _i16.OccasionsRepository(
        get<_i9.ApiClient>(),
        get<_i12.AuthService>(),
      ));
  gh.factory<_i17.SettingScreen>(() => _i17.SettingScreen(
        get<_i12.AuthService>(),
        get<_i6.LocalizationService>(),
        get<_i10.AppThemeDataService>(),
      ));
  gh.factory<_i18.SplashScreen>(
      () => _i18.SplashScreen(get<_i12.AuthService>()));
  gh.factory<_i19.FriendsCubit>(
      () => _i19.FriendsCubit(get<_i13.FriendsRepository>()));
  gh.factory<_i20.FriendsScreen>(
      () => _i20.FriendsScreen(get<_i19.FriendsCubit>()));
  gh.factory<_i21.HomePageCubit>(() => _i21.HomePageCubit(
        get<_i14.HomePageRepository>(),
        get<_i6.LocalizationService>(),
      ));
  gh.factory<_i22.HomePageScreen>(
      () => _i22.HomePageScreen(get<_i21.HomePageCubit>()));
  gh.factory<_i23.ItemDetailsScreen>(() => _i23.ItemDetailsScreen(
        get<_i21.HomePageCubit>(),
        get<_i12.AuthService>(),
      ));
  gh.factory<_i24.LoginScreen>(
      () => _i24.LoginScreen(get<_i15.LoginStateManager>()));
  gh.factory<_i25.OccasionsCubit>(
      () => _i25.OccasionsCubit(get<_i16.OccasionsRepository>()));
  gh.factory<_i26.OccasionsScreen>(
      () => _i26.OccasionsScreen(get<_i25.OccasionsCubit>()));
  gh.factory<_i27.PackagesItemsListScreen>(() => _i27.PackagesItemsListScreen(
        get<_i21.HomePageCubit>(),
        get<_i12.AuthService>(),
      ));
  gh.factory<_i28.SettingModule>(
      () => _i28.SettingModule(get<_i17.SettingScreen>()));
  gh.factory<_i29.SplashModule>(
      () => _i29.SplashModule(get<_i18.SplashScreen>()));
  gh.factory<_i30.AuthorizationModule>(
      () => _i30.AuthorizationModule(get<_i24.LoginScreen>()));
  gh.factory<_i31.FriendsModule>(
      () => _i31.FriendsModule(get<_i20.FriendsScreen>()));
  gh.factory<_i32.HomePageModule>(() => _i32.HomePageModule(
        get<_i22.HomePageScreen>(),
        get<_i27.PackagesItemsListScreen>(),
        get<_i23.ItemDetailsScreen>(),
      ));
  gh.factory<_i33.OccasionsModule>(
      () => _i33.OccasionsModule(get<_i26.OccasionsScreen>()));
  gh.factory<_i34.MyApp>(() => _i34.MyApp(
        get<_i10.AppThemeDataService>(),
        get<_i6.LocalizationService>(),
        get<_i29.SplashModule>(),
        get<_i30.AuthorizationModule>(),
        get<_i32.HomePageModule>(),
        get<_i33.OccasionsModule>(),
        get<_i28.SettingModule>(),
        get<_i31.FriendsModule>(),
      ));
  return get;
}
