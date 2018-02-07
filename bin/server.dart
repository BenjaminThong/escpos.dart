import 'dart:io';
import 'dart:convert';
import 'dart:async';

//import 'package:args/args.dart';
//import 'package:shelf/shelf.dart' as shelf;
//import 'package:shelf/shelf_io.dart' as io;

Socket gSocket;
int i = 0;
Future reconnect() async{
  print('reconnect...');
  await gSocket.close();
  gSocket.destroy();
  gSocket = await Socket.connect('127.0.0.1', 4041);
  gSocket.listen((data) {}, onDone: reconnect);
  i += 1;
  gSocket.write('Hello, World! $i');
}

Future main(List<String> args) async {
//  var parser = new ArgParser()
//    ..addOption('port', abbr: 'p', defaultsTo: '8080');
//
//  var result = parser.parse(args);
//
//  var port = int.parse(result['port'], onError: (val) {
//    stdout.writeln('Could not parse port value "$val" into a number.');
//    exit(1);
//  });
//
//  var handler = const shelf.Pipeline()
//      .addMiddleware(shelf.logRequests())
//      .addHandler(_echoRequest);
//
//  io.serve(handler, '0.0.0.0', port).then((server) {
//    print('Serving at http://${server.address.host}:${server.port}');
//  });
//  print('xoxo');
  ServerSocket.bind('127.0.0.1', 4041)
      .then((serverSocket) {
    serverSocket.listen((socket) {
      socket.transform(UTF8.decoder).listen((String data) async {
        print(data);
        print('closing..');
        await socket.close();
        socket.destroy();
        print('closed');
      });
    });
  });

  gSocket = await Socket.connect('127.0.0.1', 4041);
  gSocket.listen((data) {}, onDone: reconnect);
  gSocket.write('Hello, World!');
//  var res = await gSocket.flush();
//  print('hahas ${res}');
//  Socket.connect('127.0.0.1', 4041).then((socket) async {
//    socket.write('Hello, World!');
//  });


//  String s = "aA";
//  print(s.codeUnits);
}

//shelf.Response _echoRequest(shelf.Request request) {
//  return new shelf.Response.ok('Request for "${request.url}"');
//}
