part of spaceinvader;

class Ship extends Drawable{
  
  static num width= 40;
  static num height= 30;
  static const SPEED= 10;
  var keyDownHandler;
  var img; 
  
  Ship(Stage stage, [num x, num y]) : super(stage, x, y){
    keyDownHandler = onKeyDown;
    window.on.keyDown.add(onKeyDown);
    img = res[Images.SHIP];
  }
  
  render(time){
    super.render(time);
    context.drawImage(img, x, y, width, height);
  }
  
  destroy (){
    super.destroy();
    window.on.keyDown.remove(onKeyDown);
  }
  
  onKeyDown (KeyboardEvent event){
    if (event.keyCode == KeyCode.LEFT){ 
      x -= SPEED;
    } else if (event.keyCode == KeyCode.RIGHT){ 
      x += SPEED;
    }
    if (event.keyCode == KeyCode.SPACE){
      stage.addToRenderingCycle(new Missile (stage, x+(width/2), y));
    }
  }
}
