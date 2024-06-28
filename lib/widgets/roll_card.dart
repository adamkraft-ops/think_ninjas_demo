import 'package:flutter/material.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_router.dart';
import '../common/constants.dart';

class RoleCard extends StatefulWidget {
  final String role;
  final Color color;
  final double boxWidth;
  final double boxHeight;
  final double iconSize;
  final double fontSize;

  const RoleCard({
    super.key,
    required this.role,
    required this.color,
    required this.boxWidth,
    required this.boxHeight,
    required this.iconSize,
    required this.fontSize,
  });

  @override
  _RoleCardState createState() => _RoleCardState();
}

class _RoleCardState extends State<RoleCard> with TickerProviderStateMixin {
  bool _isClicked = false;

  void _handleTap() {
    setState(() {
      _isClicked = true;
    });

    Future.delayed(Duration(milliseconds: Delay.milliseconds_three_hundred), () {
      String routeName;
      switch (widget.role.toLowerCase()) {
        case 'waiter':
          routeName = AppRouter.password;
          break;
        case 'user':
          routeName = AppRouter.userMain;
          break;
        case 'kitchen':
          routeName = AppRouter.password;
          break;
        default:
          routeName = AppRouter.rollSelector;
          break;
      }
      Navigator.pushNamed(context, routeName, arguments: widget.role.toLowerCase())
          .then((_) {
        setState(() {
          _isClicked = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: TranslationAnimatedWidget.tween(
        enabled: _isClicked,
        duration: Duration(milliseconds: Delay.milliseconds_three_hundred),
        translationDisabled: Offset(Translation_Offset.zero, Translation_Offset.zero),
        translationEnabled: Offset(Translation_Offset.zero, Translation_Offset.minus_ten),
        child: ScaleAnimatedWidget.tween(
          enabled: _isClicked,
          duration: Duration(milliseconds: Delay.milliseconds_three_hundred),
          scaleDisabled: 1.0,
          scaleEnabled: 1.2,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Width.boarder_ten),
              side: BorderSide(color: Colors.grey, width: Width.boarder_two),
            ),
            elevation: Elevation_Amount.ten,
            shadowColor: Colors.black54,
            color: widget.color,
            child: Container(
              width: widget.boxWidth,
              height: widget.boxHeight,
              padding: EdgeInsets.all(Padding_Class.twenty),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person, size: widget.iconSize, color: Colors.white),
                  SizedBox(height: Height.twenty),
                  Text(
                    widget.role,
                    style: GoogleFonts.pacifico(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: widget.fontSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
