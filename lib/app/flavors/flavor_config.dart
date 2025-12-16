import 'flavor.dart';


class FlavorConfig {
  FlavorConfig._();

  static Flavor _flavor = Flavor.dev; // ✅ safe default

  static Flavor get flavor => _flavor;

  static void init(Flavor flavor) {
    _flavor = flavor;
  }

  static bool get isDev => _flavor == Flavor.dev;
  static bool get isProd => _flavor == Flavor.prod;
}
