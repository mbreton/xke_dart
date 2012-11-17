part of spaceinvader;

class Menu extends State{
  
  Menu(stage) : super(stage);
  
  render(){
    super.render();
    context.fillStyle = "rgba(0, 0, 0, 1)";
    context.fillRect(0, 0, 600, 400);
    context.font= "normal 36px Verdana";
    context.fillStyle= "#FFFFFF";
    context.fillText("Press space bar to begin ...", 50, 190);
  }
  
  onKeyPress (KeyboardEvent event){
    if (event.charCode == KeyCode.SPACE){ 
      nextState();
    }
  }
}
