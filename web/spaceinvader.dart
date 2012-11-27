part of spaceinvader;

// Write you code in this file

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

class Ship extends Drawable{
  static int width= 34;
  static int height= 25;
  var img;
  
  Ship(Stage stage, [int x, int y]) : super(stage, x, y){
    img = resources[Images.SHIP];
  }
}

/*class Ship extends Drawable{
  
  static int width= 34;
  static int height= 25;
  static const SPEED= 10;
  
  var keyUpHandler;
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
}*/
