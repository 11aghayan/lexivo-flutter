import 'package:flutter/scheduler.dart';

class FilterData {
  final String label;
  final dynamic value;
  final Function() updateState;
  bool selected;

  FilterData(this.label, this.value, this.selected, this.updateState);

  void toggleSelected() {
    selected = !selected;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      updateState();
    });
  }
}
