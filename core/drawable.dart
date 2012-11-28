part of spaceinvader;

abstract class Drawable extends Stagable{
  
  int x = 0, y= 0;
  double _lastTime=0.0;
  static num width=0, height=0;
  
  Drawable (stage, [this.x, this.y]): super(stage);
  
  init (){}
  render (double time){}
  destroy(){
    stage.removeFromRenderingCycle(this);
  }
  
  refresh(double time){
    if (_lastTime != 0.0){
      render(time-_lastTime);
    }
    _lastTime = time;
  }
}
