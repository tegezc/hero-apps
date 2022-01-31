import 'package:hero/config/configuration_sf.dart';
import 'package:hero/model/profile.dart';
import 'package:hero/util/constapp/accountcontroller.dart';

class HttpBase {
  ConfigurationSf configuration = ConfigurationSf();

  Future<Map<String, String>> getHeader() async {
    Profile profile = await AccountHore.getProfile();
    // --header 'Auth-Key: restapihore' \
    // --header 'Client-Service: frontendclienthore' \
    // --header 'User-ID: SSF045' \
    // --header 'Auth-session: f7baaa64480b14443dab3134ecf4727c' \
    // --header 'Id-Level: 5' \
    // --header 'Nama-Sales: EDI SUPRIANTO' \
    // --header 'Id-Tap: TAP007' \
    // --header 'Nama-Tap: TAP JEBUS' \
    // --header 'Id-Cluster: CTR011' \
    // --header 'Nama-Cluster: Bangka Belitung' \

    return {
      'Auth-Key': 'restapihore',
      'Client-Service': 'frontendclienthore',
      'User-ID': '${profile.id}',
      'Auth-session': '${profile.token}',
      'Id-Level': '${profile.role}',
      'Nama-Sales': '${profile.namaSales}',
      'Id-Tap': '${profile.idtap}',
      'Nama-Tap': '${profile.namaTap}',
      'Id-Cluster': '${profile.idcluster}',
      'Nama-Cluster': '${profile.namaCluster}',
    };
  }

  Future<Map<String, String>> getHeaderLogin() async {
    return {
      'Auth-Key': 'restapihore',
      'Client-Service': 'frontendclienthore',
      'simplerestapihoresumbagsel': '',
    };
  }
}
