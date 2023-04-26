import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:niaz_shopping/config/constants.dart';

class DropLoading extends StatelessWidget {
  const DropLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.inkDrop(
      color: CustomColors.lightAmber,
      size: 35,
    );
  }
}
