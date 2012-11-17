part of spaceinvader;

class Menu extends State{
  
  var keyPressHandler;
  
  Menu(stage) : super(stage){
    keyPressHandler = _onKeyPress;
  }
  
  render(){
    context.fillStyle = "rgba(0, 0, 0, 1)";
    context.fillRect(0, 0, 600, 400);
    context.font= "normal 36px Verdana";
    context.fillStyle= "#FFFFFF";
    context.fillText("Press space bar to begin ...", 50, 50);
   
    window.on.keyPress.add(keyPressHandler);  
  }
  
  _onKeyPress (KeyboardEvent event){
    if (event.charCode == KeyCode.SPACE){
      print("Space pressed");
      nextState();
    }
  }
  
  destroy(){
    print("destroyed !");
    window.on.keyPress.remove(keyPressHandler);
  }
}
