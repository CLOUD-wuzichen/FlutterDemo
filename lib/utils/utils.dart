////搜索
typedef SearchCallback = void Function(String title);

////滚动监听
typedef ScrollCallback = void Function(double value);

abstract class ScrollListenable {
  void addListener(ScrollCallback callback);
}

class CustomScrollController implements ScrollListenable {
  ScrollCallback _callback;

  @override
  void addListener(ScrollCallback callback) {
    this._callback = callback;
  }

  void notify(double value) {
    _callback(value);
  }
}
