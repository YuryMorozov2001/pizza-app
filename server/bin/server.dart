import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:server/helper.dart';
import 'package:server/rest_api.dart';
import 'package:server/ws_api.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

void main(List<String> arguments) async {
  final db = await Db.create('mongodb://admin:pass@localhost:27018/admin');

  await db.open();
  final coll = db.collection('orders');

  const port = 8082;
  final app = Router();

  app.mount('/pizza/', RestApi().router);
  app.mount('/pizza-ws/', OrdersScoketApi(coll).router);

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(handleCors())
      .addHandler(app);

  withHotreload(() => serve(handler, InternetAddress.anyIPv4, port));
}
