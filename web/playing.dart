part of spaceinvader;

class Playing extends State{
  
  const BACKGROUND_PATH= '_/img/space2.png';
  const MIN_ELAPSED_TIME_BETWEEN_ALIEN_SPWANING = 700;
  var keyPressHandler;
  var img;
  var imgLoaded=false;
  double elaspedTime = 0.0;
  double lastAlienSpawingTime = 0.0;
  
  Playing(stage) : super(stage){
    img = new Element.tag('img');
    img.on.load.add((event) => imgLoaded=true);
    img.src = BACKGROUND_PATH;
    keyPressHandler = onKeyPress;//TMP
  }
  
  init (){
    window.on.keyPress.add(keyPressHandler);//TMP
    addToRenderingCycle(new Ship (stage, State.width/2-Ship.width, State.height-Ship.height));
  }
  
  render([double time]){
    if (imgLoaded){
      context.drawImage(img,x,y);
    }
    elaspedTime = time - lastAlienSpawingTime;
    if (elaspedTime > MIN_ELAPSED_TIME_BETWEEN_ALIEN_SPWANING){
      //print('alien spwanned');
      lastAlienSpawingTime = time;
      Alien alien = new Alien (drawables.length.toString(), stage, 0, 0);
      addToRenderingCycle(alien);
    }
    
    super.render(time);
  }
  
  destroy (){//TMP
    super.destroy();
    window.on.keyPress.remove(keyPressHandler);
  }
  
  onKeyPress (KeyboardEvent event){
    // TMP : to test to go to last state
    if (event.charCode == KeyCode.ENTER){ 
      nextState();
    }
  }
}
