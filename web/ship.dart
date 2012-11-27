part of spaceinvader;

class Ship extends Drawable{
  
  static int width= 34;
  static int height= 25;
  static const SPEED= 10;
  
  var keyUpHandler;
  double lastProjectileSpwaningTime = 0.0;
  var img; 
  
  Ship(Stage stage, [int x, int y]) : super(stage, x, y){
    keyUpHandler = onKeyUp;
    window.on.keyUp.add(keyUpHandler);
    img = res[Images.SHIP];
  }
  
  render(time){
    context.drawImage(img, x, y, width, height);
  }
  
  destroy (){
    super.destroy();
    window.on.keyUp.remove(keyUpHandler);
  }
  
  onKeyUp (KeyboardEvent event){
    if (event.keyCode == KeyCode.LEFT){
      if (x - SPEED >=  0) x -= SPEED;
    } else if (event.keyCode == KeyCode.RIGHT){ 
      if (x+width + SPEED <=  Stage.width) x += SPEED;
    }
    if (event.keyCode == KeyCode.SPACE){
        stage.addToRenderingCycle(new Projectile (stage, (x+(width/2)).toInt(), y));
    }
  }
}
