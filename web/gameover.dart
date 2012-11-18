part of spaceinvader;

class GameOver extends State{
  
  var keyPressHandler;
  
  GameOver(stage) : super(stage){
    keyPressHandler = onKeyPress;
  }
  
  init (){
    window.on.keyPress.add(keyPressHandler);
  }
  
  render([double elapsedTime]){
    context.fillStyle = "rgba(0, 0, 0, 1)";
    context.fillRect(0, 0, 600, 400);
    context.font= "normal 36px Verdana";
    context.fillStyle= "#FFFFFF";
    context.fillText("You loose ! Press space bar to restart ...", 1, 190, 599);
  }
  
  destroy (){
    window.on.keyPress.remove(keyPressHandler);
  }
  
  onKeyPress (KeyboardEvent event){
    if (event.charCode == KeyCode.SPACE){ 
      previousState();
    }
  }
}
