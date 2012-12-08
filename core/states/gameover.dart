part of spaceinvaders;

class GameOver extends State{
  
  var keyPressHandler;
  
  GameOver(stage) : super(stage){
    keyPressHandler = onKeyPress;
  }
  
  init (){
    window.on.keyPress.add(keyPressHandler);
  }
  
  render(time){
    super.render(time);
    context.fillStyle = 'white';
    context.font = "24pt Helvetica";
    context.fillText("You Lose ! Press space to restart", 80, 200);
  }
  
  destroy (){
    window.on.keyPress.remove(keyPressHandler);
  }
  
  onKeyPress (KeyboardEvent event){
    if (event.keyCode == KeyCode.SPACE){ 
      previousState();
    }
  }
}
