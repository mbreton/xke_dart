part of spaceinvader;

abstract class State extends Stagable{
  
  int get width => Stage.width;
  int get height => Stage.height;
  
  State(stage):super(stage){
  }
  
  render (time){
    context.fillStyle = "black";
    context.fillRect(0, 0, width, height);
  }
  
  destroy(){
    stage.removeAllFromRenderingCycle();
  }
  
  nextState () => stage.nextState();
  previousState() => stage.previousState();
}
