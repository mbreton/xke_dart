part of spaceinvaders;

abstract class Drawable extends Stagable{
  
  int x = 0, y= 0;
  double _lastTime=0.0;
  static num width=0, height=0;
  var img;
  
  Drawable (stage, [this.x, this.y]): super(stage);
  
  init (){}
  render (double time){
    context.drawImage(img, x, y);
  }
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
