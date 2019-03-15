import 'package:event_bus/event_bus.dart';

class ApplicationEvent {
  static EventBus event;
  static getInstance() {
    if (event == null) {
      event = new EventBus();
    }
    return event;
  }
}

class CollectionEvent {
  CollectionEvent();
}
