class ConstApp {
//  static const String _host = 'horedev.com'; //Development
  static const String _host = 'sihore.com'; //Production
  static const String domain = 'https://$_host/apihore/index.php';
  static const String keyOutlet = 'OUT';
  static const String keySekolah = 'SEK';
  static const String keyFakultas = 'FAK';
  static const String keyKampus = 'KAM';
  static const String keyPOI = 'POI';

  static Uri uri(String path) => Uri.https(_host, '/apihore/index.php$path');
}
