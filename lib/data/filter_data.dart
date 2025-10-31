import 'package:flutter/scheduler.dart';

class FilterData {
  final String label;
  final dynamic value;
  final Function() _updateState;
  bool selected;

  FilterData(this.label, this.value, this.selected, this._updateState);

  void toggleSelected() {
    selected = !selected;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _updateState();
    });
  }
}
