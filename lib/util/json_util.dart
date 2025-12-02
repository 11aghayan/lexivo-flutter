import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

/// Exports the given [data] as a JSON file by opening the platform save-file dialog.
///
/// The [data] value is JSON-encoded (via `jsonEncode`) and UTF-8 encoded to bytes
/// before being written. The provided [filename] will be used as the base name;
/// the function appends the ".json" extension when invoking the save dialog.
///
/// Returns a [Future<bool>] that completes with:
/// - `true` if the save dialog was dismissed/canceled (no file path was returned),
/// - `false` if a file path was returned (indicating the user selected a location
///   and the save request completed).
///
/// Note: This function delegates to the platform file picker implementation and
/// may throw exceptions propagated from JSON encoding or the file picker plugin;
/// callers should handle errors (e.g., with try/catch) as appropriate.

Future<bool> exportJsonData({
  required dynamic data,
  required String filename,
}) async {
  Uint8List dataBytes = Uint8List.fromList(utf8.encode(jsonEncode(data)));

  String? response = await FilePicker.platform.saveFile(
    bytes: dataBytes,
    fileName: "$filename.json",
  );

  return response == null;
}

/// Prompts the user to select a JSON file and imports its contents.
///
/// Uses FilePicker to allow user selection of a single .json file.
/// Reads the selected file's contents and decodes it from JSON format.
///
/// Returns:
/// - The decoded JSON data as a dynamic object if successful
/// - null if:
///   - User cancels file selection
///   - Selected file path is null
///
/// Throws:
/// - FormatException if the file contents are not valid JSON
/// - FileSystemException if there are issues reading the file

Future<dynamic> importJsonData() async {
  var result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowMultiple: false,
    allowedExtensions: ["json"],
  );
  if (result == null) return null;

  final platformFile = result.files[0];
  if (platformFile.path == null) return null;

  File file = File(platformFile.path!);
  String stringData = await file.readAsString();

  return jsonDecode(stringData);
}

/// Extracts the self ID from a joined ID string.
///
/// Takes a [joinedId] in the format "selfId@otherId" and returns only the
/// self ID portion (the part before the "@" symbol).
///
/// Example:
/// ```dart
/// extractSelfIdFromJoinedId("user123@server456"); // Returns "user123"
/// ```
///
/// Parameters:
///   - [joinedId]: A string containing a self ID and other ID separated by "@"
///
/// Returns:
///   The self ID portion of the joined ID string.
String extractSelfIdFromJoinedId(String joinedId) {
  return joinedId.split("@")[0];
}




/// Creates a joined identifier by concatenating [selfId] and [otherId] with an '@' separator.
/// 
/// Example:
/// ```dart
/// createJoinedId('user123', 'group456'); // returns 'user123@group456'
/// ```
String createJoinedId(String selfId, String otherId) {
  return "$selfId@$otherId";
}
