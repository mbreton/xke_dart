part of spaceinvaders;

class Images {

  // Paths of all images to load
  static const String SHIP       = "_/img/ship.png";
  static const String ALIEN      = "_/img/normal-alien.png";
  static const String BAD_ALIEN  = "_/img/bad-alien.png";
  static const String PROJECTILE = "_/img/projectile.png";
  static const String SPACE2     = "_/img/space2.png";
  
  // return all image declared in Images for more convenience
  static get allPaths => [
                   Images.SHIP,
                   Images.ALIEN,
                   Images.BAD_ALIEN,
                   Images.PROJECTILE,
                   Images.SPACE2
                   ];
  
  /**
   * This method load an image with a given path
   * and return a Future to notified when the
   * loading is ended.
   */
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
