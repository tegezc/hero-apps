import 'dart:async';

import 'package:flutter/material.dart';

class SwipeBackObserver extends NavigatorObserver {
  static late Completer promise = Completer();

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    // make a promise
    promise = Completer();
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    // resolve the promise
    promise.complete();
  }
}

class CommonUi {
  Future<Object?> openPage(context, Widget builder) async {
    // wait until animation finished
    // await SwipeBackObserver.promise.future;

    return await Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => builder),
    );
  }
}
