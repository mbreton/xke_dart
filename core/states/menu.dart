part of spaceinvaders;

class Menu extends State{
  
  var keyPressHandler;
  
  Menu(stage) : super(stage){
    keyPressHandler = onKeyPress;
  }
  
  init (){
    publisher.setScore (0);
    window.on.keyPress.add(keyPressHandler);
  }
  
  destroy (){
    window.on.keyPress.remove(keyPressHandler);
  }
  
  render(time){
    super.render(time);
    context.fillStyle = 'white';
    context.font = "24pt Helvetica";
    context.fillText("Press space to start", 140, 200);
  }
  
  onKeyPress (KeyboardEvent event){
    if (event.keyCode == KeyCode.SPACE){ 
      nextState();
    }
  }
}
