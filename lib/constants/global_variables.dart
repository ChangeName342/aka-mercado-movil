import 'package:flutter/material.dart';

String uri = 'https://aka-mercado.heroku.com/';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromRGBO(220, 53, 69, 1),
      Color.fromRGBO(220, 53, 69, 1),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(220, 53, 69, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = const Color.fromRGBO(220, 53, 69, 1)!;
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://i.postimg.cc/BvJLy0w8/sucursal.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Bebestibles',
      'image': 'assets/images/bebestibles.png',
    },
    {
      'title': 'Abarrotes',
      'image': 'assets/images/abarrotes.png',
    },
    {
      'title': 'Carnes',
      'image': 'assets/images/carnes.png',
    },
    {
      'title': 'Lácteos',
      'image': 'assets/images/lacteos.png',
    },
    {
      'title': 'Congelados',
      'image': 'assets/images/congelados.png',
    },
  ];
}