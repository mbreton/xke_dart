part of spaceinvader;

abstract class Drawable {
  
  Stage stage;
  num x, y;
  num lastX, lastY;
  static const width=0;
  static const height = 0;
  CanvasRenderingContext2D get context => stage.canvas.getContext("2d");
  
  Drawable (this.stage, [this.x, this.y]);
  
  init ();
  render ([double time]);
  destroy ();
  
  updateRender(double time){
    render(time);
    lastX = x;
    lastY = y;
  }
}
