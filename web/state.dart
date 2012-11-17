part of spaceinvader;

class State{

  Stage _stage;
  //Stage get stage => _stage;
  
  CanvasRenderingContext2D get context => _stage.canvas.getContext("2d");
  CanvasElement get canvas => _stage.canvas;
  
  State(this._stage){
  }
  
  destroy (){
  }
  
  render (){
  }
  
  nextState (){
    _stage.nextState();
  }
}
