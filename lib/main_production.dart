import 'package:axlerate/config/config.dart';
import 'package:axlerate/main.dart';
import 'package:flavor/flavor.dart';

void main() {
  Flavor.create(
    Environment.production,
    // color: Colors.blue,
    // name: 'PRODUCTION',
    properties: {
      Keys.apiUrl: 'https://apiv2.axlerate.com',
      Keys.apiKey: Config.siteKey,
    },
  );
  setupApp();
}
