
/// Returns the trimmed version of the string with the every word capitalized.
String capitalCase(String str) {
  return str.split(" ").map((str) => str = "${str[0].toUpperCase()}${str.substring(1)}").join(" ");
}

/// Returns the trimmed version of the string with the first character capitalized.
String capitalize(String str) {
  return "${str[0].toUpperCase()}${str.substring(1)}";
}