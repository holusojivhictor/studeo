import 'dart:io';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:studeo/src/features/common/domain/constants.dart';
import 'package:studeo/src/features/common/presentation/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkUtils {
  static final ChromeSafariBrowser _browser = ChromeSafariBrowser();

  static void launchInExternalBrowser(
    String link,
  ) {
    final uri = Uri.parse(link);
    launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  static void launch(
    String link, {
    bool useReader = true,
  }) {
    WebUri rinseLink(String link) {
      final regex = RegExp(RegExpConstants.linkSuffix);
      if (link.contains(regex)) {
        final match = regex.stringMatch(link) ?? '';
        return WebUri.uri(Uri.parse(link.replaceAll(match, '')));
      }

      return WebUri.uri(Uri.parse(link));
    }

    final uri = rinseLink(link);
    canLaunchUrl(uri).then((bool val) {
      if (val) {
        if (link.contains('http')) {
          if (Platform.isAndroid) {
            launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            _browser
                .open(
                  url: uri,
                  settings: ChromeSafariBrowserSettings(
                    entersReaderIfAvailable: useReader,
                    preferredControlTintColor: AppColors.secondary,
                  ),
                )
                .onError((_, __) => launchUrl(uri));
          }
        } else {
          launchUrl(uri);
        }
      }
    });
  }
}
