import 'package:flutter/material.dart';
import 'package:lexivo_flutter/constants/sizes.dart';
import 'package:lexivo_flutter/views/widgets/components/custom_divider_widget.dart';

class WordCardWidget extends StatelessWidget {
  const WordCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Clicked")));
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(Sizes.mainPaddingMobile),
            width: double.infinity,
            color: Colors.transparent,
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 4,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("noun"), Text("masculine")],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: twoEntryData(),
                ),
                CustomDividerWidget(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("to see"), Text("(something)")],
                ),
              ],
            ),
          ),
          CustomDividerWidget(),
        ],
      ),
    );
  }

  List<Widget> verbData() {
    return [
      Text("sehen"),
      Text("(etw Akk)"),
      Text("sah"),
      Text("haben gesehen"),
    ];
  }

  List<Widget> nounData() {
    return [
      Text("der Zug"),
      Text("(auch Das)"),
      Text("die Züge"),
    ];
  }

  List<Widget> twoEntryData() {
    return [
      Text("bald"),
      Text("(details)"),
    ];
  }
}
