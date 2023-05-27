import 'package:url_launcher/url_launcher.dart';

launchURL(String url) async {
  if (await canLaunchUrl(url as Uri)) {
    await launchUrl(url as Uri);
  } else {
    throw 'Não foi possível exibir o site! Erro: $url';
  }
}
