import 'package:flutter/foundation.dart';

class NotificationsState with ChangeNotifier {
  int _unreadCount = 0;

  int get unreadCount => _unreadCount;

  void setUnreadCount(int count) {
    _unreadCount = count;
    notifyListeners();
  }

  void increment() {
    _unreadCount++;
    notifyListeners();
  }

  void clear() {
    _unreadCount = 0;
    notifyListeners();
  }
}