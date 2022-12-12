import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtil {
  static openWXArticle(String query) async {
    Uri uri =
        Uri(scheme: 'https', host: 'mp.weixin.qq.com', path: 's', query: query);
    await launchURL(uri);
  }

  static launchURL(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // throw 'Could not launch $uri';
    }
  }
}
