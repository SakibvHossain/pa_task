import '../../main.dart' as app;
import 'flavor.dart';
import 'flavor_config.dart';

void main() {
  FlavorConfig.init(Flavor.dev);
  app.main();
}
