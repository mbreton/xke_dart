part of spaceinvaders;

class Projectile extends Drawable{
  
  static num width= 5;
  static num height= 10;
  static const SPEED= 10;  
  var img;

  Projectile(Stage stage, [int x, int y]) : super(stage, x, y){
    img = resources[Images.PROJECTILE];
    stage.addToRenderingCycle(this);
  }
  
  /**
   * A project go up while 
   * is not out of the stage
   */
  render (time){
    if (y < 0){
      destroy();
    } else{
      y -= (0.5 * time).toInt();
    }
    super.render(time);
  }
  
  // to check collision with an alien
  hasCollisionWith(Drawable alien){
    return !(alien.x + Alien.width < x ||
        alien.x > x + width ||
        alien.y + Alien.height < y ||
        alien.y > y + height);
  }
}
