import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/strings/strings.dart';
import 'package:lexivo_flutter/enums/app_lang_enum.dart';

class PageData {
  final String _label;
  final Widget icon;
  final Widget pageWidget;

  PageData(this._label, this.icon, this.pageWidget);

  String getLabel(AppLang lang) {
    return KStrings.getStringsForLang(lang)[_label];
  }
}