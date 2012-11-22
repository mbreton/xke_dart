part of spaceinvader;


class Resources {
  
  static const String SHIP       = "_/img/ship.png";
  static const String ALIEN      = "_/img/normal-alien.png";
  static const String BAD_ALIEN  = "_/img/bad-alien.png";
  static const String MISSILE    = "_/img/missile.png";
  static const String SPACE2     = "_/img/space2.png";
  
  Map<String, Element> _imgs;
  ImageElement getImg (String name) => _imgs[name];
  
  static Resources instance;
  factory Resources() {
    if (instance == null) {
      instance = new Resources._internal();
    }
    return instance;
  }
  
  Resources._internal(){
    _imgs = new Map();
    loadImages();
  }
  
  loadImages (){
    Futures.wait([
        loadImage (SHIP),
        loadImage (ALIEN),
        loadImage (BAD_ALIEN),
        loadImage (MISSILE),
        loadImage (SPACE2)
    ]).then( (imageTuples){
      imageTuples.forEach((imagesTuple){
        _imgs[imagesTuple[0]] = imagesTuple[1];
      });
    });
  }
  
  Future loadImage (String path){
    var completer = new Completer();
    var img = new Element.tag('img');
    img.on.load.add((event){
      var tuple = [path,img];
      completer.complete(tuple);
    });
    img.src = path;
    return completer.future;
  }
}
