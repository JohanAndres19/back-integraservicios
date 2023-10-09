import 'package:angel3_framework/angel3_framework.dart';
import 'package:angel3_jael/angel3_jael.dart';
import 'package:angel3_static/angel3_static.dart';
import 'package:file/file.dart';

AngelConfigurer configureServer(FileSystem fileSystem) {
  return (Angel app) async {
    //await app.configure(configuration(fileSystem));
    await app.configure(jael(fileSystem.directory('views')),
    );
    
    var vDir = VirtualDirectory(app, fileSystem, source: fileSystem.directory('web'));
    
    app.fallback(vDir.handleRequest);

  };
}
