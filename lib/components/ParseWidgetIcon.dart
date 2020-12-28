import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget parseWidget(nameWidget) {
  switch (nameWidget) {
    case 'Facebook':
      return Icon(
        FontAwesomeIcons.facebookSquare,
        size: 60,
        color: Color(0xFF1773EA),
      );
    case 'Instagram':
      return ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.0, 0.25, 0.50, 0.75, 1.0],
            colors: [Color(0xFFfeda75), Color(0xFFfa7e1e), Color(0xFFd62976), Color(0xFF962fbf), Color(0xFF4f5bd5)]).createShader(bounds),
        child: Icon(
          FontAwesomeIcons.instagramSquare,
          size: 60,
          color: Colors.white,
        ),
      );
    case 'Portifólio':
      return Icon(
        FontAwesomeIcons.pager,
        size: 60,
        color: Colors.black,
      );
    case 'Email':
      return Icon(
        FontAwesomeIcons.solidEnvelope,
        size: 60,
        color: Colors.black,
      );
    case 'Contato':
      return Icon(
        FontAwesomeIcons.idBadge,
        size: 60,
        color: Colors.black,
      );
    case 'WhatsApp':
      return Icon(
        FontAwesomeIcons.whatsappSquare,
        size: 60,
        color: Color(0xFF1AD03F),
      );
    case 'Google':
      return Icon(
        FontAwesomeIcons.googlePlusSquare,
        size: 60,
        color: Color(0xFFDA3518),
      );
    case 'GitHub':
      return Icon(
        FontAwesomeIcons.githubSquare,
        size: 60,
        color: Colors.black,
      );
    case 'Linkedin':
      return Icon(
        FontAwesomeIcons.linkedin,
        size: 60,
        color: Color(0xFF0073B1),
      );

  }
  return Icon(
    FontAwesomeIcons.times,
    size: 60,
    color: Colors.black,
  );;
}

