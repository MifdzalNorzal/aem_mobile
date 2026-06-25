import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

 
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  
  /// in english, this message translates to:
  /// **'DevCorp'**
  String get appName;

  /// Static app version string
  ///
  /// in english, this message translates to:
  /// **'v1.0.4'**
  String get appVersion;

  /// Login screen title
  ///
  /// in english, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// Email input placeholder
  ///
  /// in english, this message translates to:
  /// **'Email'**
  String get emailHint;

  /// Password input placeholder
  ///
  /// in english, this message translates to:
  /// **'Password'**
  String get passwordHint;

  /// Login button label
  ///
  /// in english, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// Forgot password link
  ///
  /// in english, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// Sign up prompt prefix
  ///
  /// in english, this message translates to:
  /// **'Don\'t have an account? '**
  String get noAccount;

  /// Sign up link label
  ///
  /// in english, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Email validation: empty
  ///
  /// in english, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// Email validation: format invalid
  ///
  /// in english, this message translates to:
  /// **'Enter a valid email'**
  String get emailInvalid;

  /// Password validation: empty
  ///
  /// in english, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// Login error dialog title
  ///
  /// in english, this message translates to:
  /// **'Login Failed'**
  String get loginFailed;

  /// Login error dialog body
  ///
  /// in english, this message translates to:
  /// **'Please check your credentials and try again.'**
  String get loginFailedMessage;

  /// Generic confirmation button
  ///
  /// in english, this message translates to:
  /// **'OK'**
  String get ok;

  /// Home screen greeting header
  ///
  /// in english, this message translates to:
  /// **'Hello, Alex'**
  String get helloAlex;

  /// Bar chart card title
  ///
  /// in english, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// Donut chart card title
  ///
  /// in english, this message translates to:
  /// **'Distribution'**
  String get distribution;

  /// Home screen error message
  ///
  /// in english, this message translates to:
  /// **'Failed to load dashboard'**
  String get failedLoadDashboard;

  /// Retry button label
  ///
  /// in english, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Search bar placeholder
  ///
  /// in english, this message translates to:
  /// **'Search'**
  String get search;

  /// Info screen error message
  ///
  /// in english, this message translates to:
  /// **'Failed to load employees'**
  String get failedLoadEmployees;

  /// Info screen empty search result
  ///
  /// in english, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// Fallback department label for employees
  ///
  /// in english, this message translates to:
  /// **'Department'**
  String get defaultDepartment;

  /// Fallback role label for employees
  ///
  /// in english, this message translates to:
  /// **'Senior Developer - iOS'**
  String get defaultRole;

  /// Hardcoded profile name on settings screen
  ///
  /// in english, this message translates to:
  /// **'Alex Johnson'**
  String get profileName;

  /// Hardcoded profile role on settings screen
  ///
  /// in english, this message translates to:
  /// **'Senior Developer'**
  String get profileRole;

  /// Settings menu item
  ///
  /// in english, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// Settings toggle label
  ///
  /// in english, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Settings toggle label
  ///
  /// in english, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Settings row label for app version
  ///
  /// in english, this message translates to:
  /// **'App Version'**
  String get appVersionLabel;

  /// Logout button label
  ///
  /// in english, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// Bottom nav: home tab
  ///
  /// in english, this message translates to:
  /// **'Home'**
  String get navHome;

  /// Bottom nav: info tab
  ///
  /// in english, this message translates to:
  /// **'Info'**
  String get navInfo;

  /// Bottom nav: settings tab
  ///
  /// in english, this message translates to:
  /// **'Settings'**
  String get navSettings;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
