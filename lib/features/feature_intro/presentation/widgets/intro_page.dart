import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:niaz_shopping/config/constants.dart';
import 'package:shimmer/shimmer.dart';

class IntroPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  const IntroPage({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// get device size
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// image
        SizedBox(
          width: width,
          height: height * 0.6,
          child: DelayedWidget(
            delayDuration: const Duration(milliseconds: 200),
            animationDuration: const Duration(seconds: 1),
            animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
            child: Transform.scale(scale: 0.6, child: Image.asset(image)),
          ),
        ),
        const SizedBox(height: 20),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: DelayedWidget(
            delayDuration: const Duration(milliseconds: 400),
            animationDuration: const Duration(seconds: 1),
            animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
            child: Text(
              title,
              style: CustomTextStyle.introBodyLarge,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: DelayedWidget(
            delayDuration: const Duration(milliseconds: 600),
            animationDuration: const Duration(seconds: 1),
            animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade800,
              highlightColor: Colors.grey,
              child: Text(
                description,
                style: CustomTextStyle.darkSmall,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
