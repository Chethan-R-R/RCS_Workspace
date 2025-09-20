/*
Author: Nagaraju.lj
Date: April,2024.
Description: connectivity state of common network listener bloc
 */

abstract class ConnectivityState {
  bool isConnected = true;
}

class ConnectivityInitial extends ConnectivityState {
  ConnectivityInitial() {
    isConnected = true;
  }
}

class Connected extends ConnectivityState {
  Connected() {
    isConnected = true;
  }
}

class Disconnected extends ConnectivityState {
  Disconnected() {
    isConnected = false;
  }
}
