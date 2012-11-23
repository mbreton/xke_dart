part of spaceinvader;

class Missile extends Drawable{
  
  static num width= 5;
  static num height= 10;
  static const SPEED= 10;  
  var img;

  Missile(Stage stage, [num x, num y]) : super(stage, x, y){
    img = res[Images.MISSILE];
  }
  
  render (time){
    if (y < 0){
      destroy();
    } else{
      y -= 10;
      context.drawImage(img, x, y);
    }
  }
  
  hasCollisionWith(Drawable alien){
    return !(alien.x + Alien.width < x ||
        alien.x > x + width ||
        alien.y + Alien.height < y ||
        alien.y > y + height);
  }
}
