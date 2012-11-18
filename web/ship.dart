part of spaceinvader;

class Ship extends Drawable{
  
  const IMG_PATH= '_/img/ship.png';
  static const width= 40;
  static const height= 30;
  static const SPEED= 10;
  var img;
  var keyDownHandler;
  var imgLoaded= false;
  
  Ship(Stage stage, [num x, num y]) : super(stage, x, y){
    img = new Element.tag('img');
    img.on.load.add((event) =>  imgLoaded=true);
    img.src = IMG_PATH;
    keyDownHandler = onKeyDown;
    window.on.keyDown.add(onKeyDown);
  }
  
  render([double time]){
    if (imgLoaded){
      context.drawImage(img,x,y, width, height);
    }
  }
  
  destroy (){
    window.on.keyDown.remove(onKeyDown);
  }
  
  onKeyDown (KeyboardEvent event){
    if (event.keyCode == KeyCode.LEFT){ 
      moveLeft();
    } else if (event.keyCode == KeyCode.RIGHT){ 
      moveRight();
    }
  }
  
  moveLeft (){
    print('moveLeft');
    x -= SPEED;  
  }
  
  moveRight (){
    print('moveRight');
    x += SPEED;
  }
}
