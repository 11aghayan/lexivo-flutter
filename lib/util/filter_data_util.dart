import 'package:lexivo_flutter/data/filter_data.dart';
import 'package:lexivo_flutter/data/notifiers.dart';
import 'package:lexivo_flutter/schema/interface/localized_to_string_interface.dart';

Set<FilterData> getFilterDataFromEnumValues(
  List<LocalizedToStringInterface> values,
  void Function() onFilterChanged,
) {
  return Set.from(
    List.generate(values.length, (index) {
      var value = values[index];
      return FilterData(
        value.toLocalizedString(appLangNotifier.value),
        value,
        false,
        onFilterChanged,
      );
    }),
  );
}
