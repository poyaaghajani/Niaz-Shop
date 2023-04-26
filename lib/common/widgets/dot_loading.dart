import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:niaz_shopping/config/constants.dart';

class DotLOading extends StatelessWidget {
  const DotLOading({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: LoadingAnimationWidget.prograssiveDots(
        color: CustomColors.lightAmber,
        size: 50,
      ),
    );
  }
}
