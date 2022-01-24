class Configuration {
  static final Configuration _configuration = Configuration._internal();

  factory Configuration() {
    return _configuration;
  }

  Configuration._internal();
  final bool _isProduction = true;
  String host() {
    if (_isProduction) {
      return 'sihore.com';
    }
    return 'horedev.com';
  }

  String domain() => 'https://${host()}/apihore/index.php';

  Uri uri(String path) => Uri.https(host(), '/apihore/index.php$path');

  bool radiusClockin({required int? maxradius, required double? actualradius}) {
    if (maxradius == null || actualradius == null) {
      return false;
    }
    if (_isProduction) {
      return actualradius <= maxradius;
    }
    return true;
  }
}
