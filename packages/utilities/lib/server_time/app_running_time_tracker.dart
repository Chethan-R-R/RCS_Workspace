class AppRunningTime {
  static AppRunningTime? _instance;
  AppRunningTime._internal();
  factory AppRunningTime() => _instance ??= AppRunningTime._internal();

  Stopwatch _watch = Stopwatch();

  void _onAppLaunch() {
    if (_watch.isRunning) {
      _watch.stop();
      _watch.reset();
    }
    _watch.start();
  }

  int getAppRunningTimeInSeconds() {
    return _watch.elapsed.inSeconds;
  }

  void resetAppRunningTime() {
    _watch.isRunning ? _watch.reset() : _watch.start();
  }
}
