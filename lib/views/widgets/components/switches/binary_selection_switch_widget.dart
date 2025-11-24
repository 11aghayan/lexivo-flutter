import 'package:flutter/material.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';

class BinarySelectionSwitchWidget extends StatefulWidget {
  const BinarySelectionSwitchWidget({
    super.key,
    required this.leftWidget,
    required this.rightWidget,
    required this.onSwitched,
    this.alignment = MainAxisAlignment.center,
  });

  final Widget leftWidget;
  final Widget rightWidget;
  final void Function() onSwitched;
  final MainAxisAlignment alignment;

  @override
  State<BinarySelectionSwitchWidget> createState() =>
      _BinarySelectionSwitchWidgetState();
}

class _BinarySelectionSwitchWidgetState
    extends State<BinarySelectionSwitchWidget> {
  late final colors = ThemeColors.getThemeColors(context);
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: widget.alignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 10,
      children: [
        widget.leftWidget,
        Switch(
          value: isSwitched,
          trackOutlineColor: WidgetStatePropertyAll(colors.outlinedBtnBorder),
          activeThumbColor: colors.accent,
          activeTrackColor: colors.canvas,
          inactiveThumbColor: colors.primary,
          inactiveTrackColor: colors.canvas,
          onChanged: (value) {
            widget.onSwitched();
            isSwitched = !isSwitched;
            if (mounted) {
              setState(() {});
            }
          },
        ),
        widget.rightWidget,
      ],
    );
  }
}
