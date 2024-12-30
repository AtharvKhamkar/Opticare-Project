/// Flavors to maintain
/// enviornment configuration in the app
enum Flavor {
  /// DEV enviornemnt
  /// use Dev Firebase account
  /// user Dev Terra Service Cred
  dev,

  /// STAG enviornment
  /// use STAG Firebase account
  /// user STAG Terra Service Cred
  stag,

  /// PROD enviornment
  /// use STAG Firebase account
  /// user PROD Terra Service Cred
  prod,
}

/// Flavor class
/// use to configure flutter project
/// depending on enviornment
class F {
  /// variable to store current flavor
  static Flavor? appFlavor;

  /// give current flavor name
  /// if none flavor selected then return empty string
  static String get name => appFlavor?.name ?? '';

  /// set flavor name
  static Future<void> setAppFlavor(Flavor flavor) async {
    appFlavor = flavor;
  }

  /// returns app Title based on Flavor enviornment
  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Opti Care Dev';
      case Flavor.stag:
        return 'Opti Care Stag';
      case Flavor.prod:
        return 'Opti Care';
      default:
        return 'title';
    }
  }
}
