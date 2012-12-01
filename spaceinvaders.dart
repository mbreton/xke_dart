part of spaceinvaders;

class Publisher {
  
  var scoreLabel= "";
  
  setScore (int score){
    scoreLabel = "${score} Point${score > 1 ? 's': ''}";
    js.scoped(() {
      js.context.setScoreLabel(scoreLabel);
    });
  }
}

class Resources {
  Map imgs = {};
  
  Element operator [](String key) => imgs[key];
  
  Future loadImages (){
    return Futures.wait([
         Images.loadImage(Images.SHIP),
         Images.loadImage(Images.ALIEN),
         Images.loadImage(Images.BAD_ALIEN),
         Images.loadImage(Images.PROJECTILE),
         Images.loadImage(Images.SPACE2)
    ]);
  }
}

class Alien extends Drawable{
  static final height = 30;
  static final width = 30;
  var sens = 1;
  var life = 1;
  
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
    super.render(time);
  }
  
  decreaseLive (){
    life--;
  }
  
  mutate (){
    return new VeryBadAlien.fromAlien(this);
  }
  
  get isAlive => life > 0;
  
}


class VeryBadAlien extends Alien{
  var life = 2;
  
  VeryBadAlien.fromAlien (Alien alien) : super(alien.stage, alien.x, alien.y){
    sens = alien.sens;
    img = resources[Images.BAD_ALIEN];
  }
  
  mutate (){
    return this;
  }
}

class Ship extends Drawable{
  static int width= 34;
  static int height= 25;
  static const SPEED= 10;
  var keyUpHandler;
  
  Ship(Stage stage, [int x, int y]) : super(stage, x, y){
    img = resources[Images.SHIP];
    keyUpHandler = onKeyUp;
    window.on.keyUp.add(keyUpHandler);
  }
  
  render(time){
    super.render(time);
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