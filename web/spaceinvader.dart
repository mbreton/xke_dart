part of spaceinvader;

// Write your code in this file

class Publisher {
  
  static updateScore (int score){
    js.scoped(() {
      var scoreLabel = "${score} Point${score > 1 ? 's': ''}";
      js.context.updateScoreLabel(scoreLabel);
    });
  }
}


class Resources {
  
  var imgs = new Map();
  
  Element operator [] (String path) => imgs[path];
  
  Future loadImages (List<String> paths){
    return Futures.wait( paths.map((path)  => Images.loadImage (path) ))
        ..transform((List<Element> images) => images.forEach((Element image) {
         imgs[image.attributes['src']] = image; 
      })
    );
  }
}

class Alien extends Drawable{
  
  static final height = 30;
  static final width = 30;
  var sens = 1;
  var life = 1;
  var img;
  
  Alien (stage, [x, y]): super(stage, x, y){
    img = resources[Images.ALIEN];
  }
  
  render (double time){
    if (x < 0 || x + width > Stage.width){
      x = (x < 0) ? 0 : Stage.width - width;
      y += 40;
      sens *= -1;
    }
    x += (time * 0.4 * sens).toInt();
    context.drawImage(img, x, y);
  }
  
  decreaseLive (){
    life--;
  }
  
  isAlive (){
    return life > 0;
  }
  
  mutate (){
    return new BadAlien.fromAlien(this);
  }
}

class Ship extends Drawable{
  static int width= 34;
  static int height= 25;
  static const SPEED= 10;
  var img;
  var keyUpHandler;
  
  Ship(Stage stage, [int x, int y]) : super(stage, x, y){
    img = resources[Images.SHIP];
    keyUpHandler = onKeyUp;
    window.on.keyUp.add(keyUpHandler);
  }
  
  render(time){
    context.drawImage(img, x, y, width, height);
  }
  
  destroy(){
    super.destroy();
    window.on.keyUp.remove(keyUpHandler);
  }
  
  moveLeft(){
    var nextX = x - SPEED;
    x = (nextX >=  0) ? nextX : 0;
  }
  
  moveRight(){
    var nextX = x + SPEED;
    var rigthLimit = Stage.width-width;
    x = (nextX+width <= rigthLimit) ? nextX : rigthLimit;
  }
  
  fire (){
    new Projectile (stage, (x+(width/2)).toInt(), y);
  }
  
  onKeyUp (KeyboardEvent event){
    if      (event.keyCode == KeyCode.LEFT)     moveLeft();
    else if (event.keyCode == KeyCode.RIGHT)    moveRight();
    else if (event.keyCode == KeyCode.SPACE)    fire();
  }
}
