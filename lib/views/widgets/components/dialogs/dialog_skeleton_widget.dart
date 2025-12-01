import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class DialogSkeletonWidget extends StatelessWidget {
  const DialogSkeletonWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(Sizes.mainPadding),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.maxFinite,
                constraints: BoxConstraints(maxWidth: Sizes.widgetMaxWidth),
                padding: EdgeInsets.all(Sizes.dialogInnerPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Sizes.borderRadius_1),
                  color: ThemeColors.getThemeColors(context).canvas,
                ),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
