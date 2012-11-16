part of spaceinvader;

class State {
  
  State next;
  State previous;
  
  State(){
  }
  
  State.withNext (State this.next){
    this.next.previous = this;
  }
  
  destroy (){
  }
  
  render (){
    
  }
}
