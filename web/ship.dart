part of spaceinvader;

class Ship extends Drawable{
  
  static num width= 40;
  static num height= 30;
  static const SPEED= 10;
  var keyDownHandler;
  var shipImg = (new Resources()).getImg(Resources.SHIP);
  
  Ship(Stage stage, [num x, num y]) : super(stage, x, y){
    keyDownHandler = onKeyDown;
    window.on.keyDown.add(onKeyDown);
  }
  
  render(time){
    super.render(time);
    context.drawImage(shipImg, x, y, width, height);
  }
  
  destroy (){
    super.destroy();
    window.on.keyDown.remove(onKeyDown);
  }
  
  onKeyDown (KeyboardEvent event){
    if (event.keyCode == KeyCode.LEFT){ 
      moveLeft();
    } else if (event.keyCode == KeyCode.RIGHT){ 
      moveRight();
    }
    if (event.keyCode == KeyCode.SPACE){
      stage.addToRenderingCycle(new Missile (stage, x+(width/2), y));
    }
  }
  
  moveLeft (){
    x -= SPEED;  
  }
  
  moveRight (){
    x += SPEED;
  }
}
