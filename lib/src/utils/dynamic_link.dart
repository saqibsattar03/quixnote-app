import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:quix_note/src/base/nav.dart';
import 'package:quix_note/src/components/notes/note_detail.dart';
import 'package:quix_note/src/components/notes/widgets/single_note.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';

import '../base/data.dart';
import '../service/api/note_api_config.dart';

class DynamicLinkProvide {
  static final _dynamicLink = FirebaseDynamicLinks.instance;

  static BuildContext? _context;

  static void bindContext(BuildContext context) {
    _context ??= context;
  }

  ///create the link
  ///
  Future<String> createLink(String refCode) async {
    try {
      final url = "https://com.sparkosol.quixnote?ref=$refCode";
      final parameters = DynamicLinkParameters(
        link: Uri.parse(url),
        uriPrefix: "https://quixnote.page.link/",
        androidParameters: const AndroidParameters(
          packageName: "com.sparkosol.quixnote",
          minimumVersion: 0,
        ),
      );
      // final link = FirebaseDynamicLinks.instance;
      // final refLink=  await link.buildLink(parameters);
      final refLink = await _dynamicLink.buildShortLink(parameters);
      return refLink.shortUrl.toString();
    } catch (_) {
      rethrow;
    }
  }

  /// init dynamic link
  ///
  Future<void> initDynamicLink() async {
    final link = await _dynamicLink.getInitialLink();
    if (link != null) {
      print("link found ----------------------------");
      await _handleClick(link);
      // final refLink = link.link;
      //
      // Share.share("this is the link ${refLink.queryParameters["ref"]}");
    }
    _dynamicLink.onLink.listen(_handleClick);
  }

  /// handle dynamic link
///
Future<void> _handleClick(PendingDynamicLinkData pendingDynamicLinkData) async {
  final Uri deepLink = pendingDynamicLinkData.link;

  var noteId = deepLink.queryParameters["ref"];
  print("note Id -----------------${noteId}----------------------------");
  if(noteId != null){
    if(AppData.accessToken.isNotEmpty){
      try{
        final api = NoteApiConfig();
        final result =await api.getNotesById(id: noteId);
        print('result -----------------------${result}--------------------------------');
        AppNavigation.push(NoteDetail(noteModel: result));
      }catch(_){
        print('------------------------------error------------------------------------');
      }
    }
  }
}
}
