import 'dart:async';

//import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NetworkStatus { NotDetermined, On, Off }

class NetworkDetectorNotifier extends StateNotifier<NetworkStatus> {
  StreamController<ConnectivityResult> controller =
      StreamController<ConnectivityResult>(
          onListen: () => print('listening to network'));

  late NetworkStatus lastResult;

  NetworkDetectorNotifier() : super(NetworkStatus.NotDetermined) {
    lastResult = NetworkStatus.NotDetermined;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Use Connectivity() here to gather more info if you need it
      NetworkStatus newState;
      switch (result) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
        case ConnectivityResult.vpn:
          newState = NetworkStatus.On;
          break;
        case ConnectivityResult.none:
          newState = NetworkStatus.Off;
          // TODO: Handle this case.
          break;
        // case ConnectivityResult.bluetooth:
        // TODO: Handle this case.
        default:
          newState = NetworkStatus.NotDetermined;

          break;
      }

      if (newState != state) {
        state = newState;
      }
    });
  }
  // @override
  // void dispose() {
  //   super.dispose();
  //   //subscription.cancel();
  // }
}

final networkAwareProvider = StateNotifierProvider((ref) {
  return NetworkDetectorNotifier();
});
