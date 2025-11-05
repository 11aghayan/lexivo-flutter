import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/views/theme/theme_colors.dart';
import 'package:lexivo_flutter/views/widgets/components/btns/custom_filled_button_widget.dart';

class SaveBtnWidget extends StatelessWidget {
  const SaveBtnWidget({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: Sizes.widgetMaxWidth),
      child: SizedBox(
        width: double.infinity,
        child: CustomFilledButtonWidget(
          onPressed: onPressed,
          padding: 14,
          elevation: true,
          child: Text(
            KStrings.getStringsForLang(appLangNotifier.value).save,
            style: TextStyle(
              color: ThemeColors.getThemeColors(context).contrastPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
