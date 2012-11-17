part of spaceinvader;

abstract class State{

  Stage _stage;
  var keyPressHandler;
  
  CanvasRenderingContext2D get context => _stage.canvas.getContext("2d");
  
  State(this._stage){
    keyPressHandler = onKeyPress;
  }
  
  destroy (){
    window.on.keyPress.remove(keyPressHandler);
  }
  
  render (){
    window.on.keyPress.add(keyPressHandler);
  }
  
  onKeyPress (KeyboardEvent event);
  
  nextState () => _stage.nextState();
  previousState() => _stage.previousState();
}
