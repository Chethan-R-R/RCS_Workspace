/*
class SingleClickListener {
  static int _lastClickTime = 0;
  static const int _minClickInterval = 1000;

  static bool canClick() {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final elapsedTime = currentTime - _lastClickTime;
    if (elapsedTime <= _minClickInterval) {
      return false;
    }
    _lastClickTime = currentTime;
    return true;
  }
}
*/
