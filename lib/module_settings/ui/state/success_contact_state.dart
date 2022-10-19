import 'package:cater_me_v2/abstracts/states/state.dart';
import 'package:cater_me_v2/module_settings/reponse/contact_reponse.dart';
import 'package:cater_me_v2/module_settings/ui/widgets/media_widget.dart';
import 'package:cater_me_v2/utils/images/images.dart';
import 'package:flutter/material.dart';

class SuccessContactSate extends States {
  final ContactResponse response;

  SuccessContactSate(this.response);

  @override
  Widget getUI(BuildContext context) {
    return   Wrap(
      runSpacing: 35,
      spacing: 50,
      children: [

        MediaCard(image:SocialMedia.FACEBOOK ,url:'https://www.facebook.com/caterme.ksa/' ),
        MediaCard(image:SocialMedia.INSTAGRAM ,url:'https://www.instagram.com/caterme.online/?hl=en' ),
        MediaCard(image:SocialMedia.LINKEDIN ,url:'https://www.linkedin.com/company/cater-me/' ),
        MediaCard(image:SocialMedia.WHATSAPP ,url:'https://wa.me/${response.phoneNumber}' ),
        MediaCard(image:SocialMedia.SNAPSHOT ,url:'https://www.snapchat.com/add/caterme.online?share_id=Q0UzMUVF&locale=en_US' ),
        MediaCard(image:SocialMedia.TWITTER ,url:'https://twitter.com/caterme_online' ),
        MediaCard(image:SocialMedia.WEB ,url:'https://www.caterme.online/' ),
        MediaCard(image:SocialMedia.CALL ,url:'tel://${response.phoneNumber}' ),
        MediaCard(image:SocialMedia.EMAIL ,url:'mailto:${response.email}' ),
      ],);
  }
}