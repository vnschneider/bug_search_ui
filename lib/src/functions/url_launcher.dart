import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(urlToLaunch) async {
  final Uri url = Uri.parse(urlToLaunch);

  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
    webOnlyWindowName: "_blank",
  )) {
    throw 'Não foi possível exibir o site! Erro: $url';
  }
}
