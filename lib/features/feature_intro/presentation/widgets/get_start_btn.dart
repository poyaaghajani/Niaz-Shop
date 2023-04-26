import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:niaz_shopping/config/constants.dart';

class GetStartBtn extends StatefulWidget {
  final String text;
  final Function onTap;
  const GetStartBtn({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  State<GetStartBtn> createState() => _GetStartBtnState();
}

class _GetStartBtnState extends State<GetStartBtn>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DelayedWidget(
      delayDuration: const Duration(milliseconds: 800),
      animationDuration: const Duration(seconds: 1),
      animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
      child: SizedBox(
        height: 45,
        width: 120,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            widget.onTap();
          },
          child: Text(
            widget.text,
            style: CustomTextStyle.darkMedium,
          ),
        ),
      ),
    );
  }
}
