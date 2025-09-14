import 'package:flutter/material.dart';
import '../constants/app_dimensions.dart';

class ShoppingCartIllustration extends StatelessWidget {
  const ShoppingCartIllustration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.cartSize,
      height: AppDimensions.cartSize * 0.8,
      child: CustomPaint(
        painter: ShoppingCartPainter(),
      ),
    );
  }
}

class ShoppingCartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF666666)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final fillPaint = Paint()
      ..color = const Color(0xFFFF4444)
      ..style = PaintingStyle.fill;

    // Draw cart body
    final cartRect = Rect.fromLTWH(
      size.width * 0.2, 
      size.height * 0.3, 
      size.width * 0.6, 
      size.height * 0.4
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(cartRect, const Radius.circular(4)), 
      paint
    );

    // Draw cart handle
    final handlePath = Path()
      ..moveTo(size.width * 0.15, size.height * 0.2)
      ..lineTo(size.width * 0.25, size.height * 0.2)
      ..lineTo(size.width * 0.3, size.height * 0.35);
    canvas.drawPath(handlePath, paint);

    // Draw handle grip (red)
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.2), 
      4, 
      fillPaint
    );

    // Draw wheels
    canvas.drawCircle(
      Offset(size.width * 0.35, size.height * 0.75), 
      6, 
      paint
    );
    canvas.drawCircle(
      Offset(size.width * 0.65, size.height * 0.75), 
      6, 
      paint
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
