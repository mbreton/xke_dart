part of spaceinvader;

class Images {

  static const String SHIP       = "_/img/ship.png";
  static const String ALIEN      = "_/img/normal-alien.png";
  static const String BAD_ALIEN  = "_/img/bad-alien.png";
  static const String MISSILE    = "_/img/missile.png";
  static const String SPACE2     = "_/img/space2.png";
  
  static Future loadImage (String path){
    var completer = new Completer();
    var img = new Element.tag('img');
    img.on.load.add((event) {
      completer.complete(img);
    });
    img.src = path;
    return completer.future;
  }
}
