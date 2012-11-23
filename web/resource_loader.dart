part of spaceinvader;


class ResourceLoader {
  
  Map<String, Element> _imgs; 
  
  Element operator [] (String path) => _imgs[path];
  
  ResourceLoader.fromImagePaths (List<String> paths){
    _imgs = new Map();
    Futures.wait( paths.map((path) 
        => loadImage (path)) )
    .then( (images) 
        => images.forEach((image) {
          _imgs[image.attributes['src']] = image; 
        }));
  }
  
  Future loadImage (String path){
    var completer = new Completer();
    var img = new Element.tag('img');
    img.on.load.add((event) => completer.complete(img));
    img.src = path;
    return completer.future;
  }
}
