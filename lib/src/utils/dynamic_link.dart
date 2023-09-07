import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';

class DynamicLinkProvide {
  ///create the link
  ///
  Future<String> createLink(String refCode) async {
    try {
      print("$refCode ---------------------------------------");
      final url = "http://com.example.quix_note?ref=$refCode";
      final parameters = DynamicLinkParameters(
        link: Uri.parse(url),
        uriPrefix: "https://quixnote.page.link",
        androidParameters: const AndroidParameters(
          packageName: "com.example.quix_note",
          minimumVersion: 0,
        ),
      );


      // final parameters = DynamicLinkParameters(
      //   androidParameters: const AndroidParameters(
      //     packageName: "com.example.quix_note",
      //     minimumVersion: 0,
      //   ),
      //   link: Uri.parse(url),
      //   uriPrefix: "https://quixnote.page.link",
      // );
      final link = FirebaseDynamicLinks.instance;
      final refLink = await link.buildShortLink(parameters);
      print(
          "------------------------------------------${refLink.shortUrl.toString()}--------------------------------------------------------");
      return refLink.shortUrl.toString();
    } catch (_) {
      rethrow;
    }
  }

  /// init dynamic link
  ///
  void initDynamicLink() async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (instanceLink != null) {
      final refLink = instanceLink.link;

      Share.share("this is the link ${refLink.queryParameters["ref"]}");
    }
  }
}
