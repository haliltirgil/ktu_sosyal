import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ktu_sosyal/theme.dart';

class NotFoundException extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              LogoConstants.notFound,
              height: MediaQuery.of(context).size.height / 8,
            ),
            Text(
              "Sayfa bulunamadı",
              style: KtuTextStyles.bold,
            ),
          ],
        ),
      ),
    );
  }
}
