part of spaceinvader;

abstract class State extends Stagable{
  
  num get width => Stage.width;
  num get height => Stage.height;
  
  State(stage):super(stage){
  }
  
  destroy(){
    stage.removeAllFromRenderingCycle();
  }
  
  nextState () => stage.nextState();
  previousState() => stage.previousState();
}
