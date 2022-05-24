import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subastareaspp/widgets/widgets.dart';

class SlidePage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String assetImage;
  const SlidePage({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.assetImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: SvgPicture.asset(assetImage),
          ),
          SimpleText(
            text: title,
            fontSize: 20,
            color: Colors.black,
            bottom: 10,
            top: 10,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          SimpleText(
            text: subtitle,
            fontSize: 16,
            color: Colors.black,
            textAlign: TextAlign.center,
            left: 20,
            right: 20,
          ),
        ],
      ),
    );
  }
}