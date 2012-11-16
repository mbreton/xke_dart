part of spaceinvader;

class State {

  CanvasRenderingContext2D ctx2d;
  
  State previous;
  
  State _next;
  State get next => _next;
  set next (State nextState){
    _next = nextState;
    _next.previous = this;
    return this;
  }
  
  State(this.ctx2d){
  }
  
  destroy (){
  }
  
  render (){
    
  }
}
