import 'package:flutter/material.dart';

/// App logo: mountain + tree icons and the text "Islas Canarias".
class AppLogo extends StatelessWidget {
  final double size;
  final Color color;
  final bool showText;

  const AppLogo({
    super.key,
    this.size = 80,
    this.color = Colors.white,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size * 1.3,
          height: size,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                bottom: 0,
                child: Icon(Icons.landscape, size: size, color: color),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Icon(Icons.park, size: size * 0.5, color: color),
              ),
            ],
          ),
        ),
        if (showText)
          Text(
            'Islas Canarias',
            // "Lobster" is declared in pubspec.yaml (assets/fonts)
            style: TextStyle(fontFamily: 'Lobster', fontSize: size * 0.42, color: color),
          ),
      ],
    );
  }
}
