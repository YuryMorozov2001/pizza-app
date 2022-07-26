import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class RestApi {
  Handler get router {
    final app = Router();

    app.get('/', (Request request) {
      final List data =
          json.decode(File('./json/pizza.json').readAsStringSync());
      return Response.ok(json.encode(data),
          headers: {'Content-Type': ContentType.json.mimeType});
    });

    app.get('/<id>.png', (Request request) {
      print(request.params['id']);
      File image = File('./assets/${request.params['id']}.png');
      final fileStream = image.openRead();
      return Response.ok(fileStream, headers: {'Content-Type': 'image/png'});
    });

    return app;
  }
}
