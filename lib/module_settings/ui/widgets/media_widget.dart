import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MediaCard extends StatelessWidget {
  final String image;
  final String url;
  const MediaCard({ required this.image,required this.url});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final uriUrl = Uri.parse(url);

        if (await canLaunchUrl(uriUrl)) {
          await launchUrl(uriUrl);
        }
      },
      icon: Image.asset(
        image ?? '',
        height: 55,
        width: 50,
      ),
    );
  }
}
