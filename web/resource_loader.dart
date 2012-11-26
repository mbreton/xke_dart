part of spaceinvader;


class ResourceLoader {
  
  Map<String, Element> _imgs = new Map();
  
  Element operator [] (String path) => _imgs[path];
  
  ResourceLoader.fromImagePaths (List<String> paths){
    Futures.wait( paths.map((path)  => loadImage (path) ))
    
    ..handleException((exception) {
      print('Exception : ${exception}');
    })
    
    ..then( (images) => images.forEach((image) {
      _imgs[image.attributes['src']] = image; 
    }));
  }
  
  Future loadImage (String path){
    var completer = new Completer();
    var img = new Element.tag('img');
    img.on.load.add((event) {
      completer.complete(img);
    });
    img.src = path;
    return completer.future;
  }
}
