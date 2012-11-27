part of spaceinvader;

class Projectile extends Drawable{
  
  static num width= 5;
  static num height= 10;
  static const SPEED= 10;  
  var img;

  Projectile(Stage stage, [int x, int y]) : super(stage, x, y){
    img = resources[Images.MISSILE];
  }
  
  render (time){
    if (y < 0){
      destroy();
    } else{
      y -= (0.5 * time).toInt();
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
