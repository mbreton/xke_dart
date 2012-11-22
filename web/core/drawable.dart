part of spaceinvader;

abstract class Drawable extends Stagable{
  
  num x, y;
  num lastX, lastY;
  static num width=0, height=0;
  
  Drawable (stage, [this.x, this.y]): super(stage);
  
  init (){}
  render (time){}
  destroy(){
    stage.removeFromRenderingCycle(this);
  }
  
  updateRender(time){
    render(time);
    lastX = x;
    lastY = y;
  }
}
