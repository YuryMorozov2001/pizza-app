import 'package:flutter/material.dart';
import '../const/const.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketApi {
  WebSocketApi() : _api = WebSocketChannel.connect(Uri.parse(wsUrl));
  final WebSocketChannel _api;

  Stream get stream => _api.stream.cast();

  ValueChanged<String> get send => _api.sink.add;
}
