/// The utility get method for dynamic greeting based on time .
String get greeting {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good morning';
  }
  if (hour < 17) {
    return 'Good afternoon';
  }
  return 'Good Evening';
}
