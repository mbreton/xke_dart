part of spaceinvader;

abstract class Drawable {
  
  Stage stage;
  num x, y;
  num lastX, lastY;
  static const width=0;
  static const height = 0;
  CanvasRenderingContext2D get context => stage.canvas.getContext("2d");
  List<Drawable> drawables = new List<Drawable>();
  
  Drawable (this.stage, [this.x, this.y]);
  
  init ();
  render ([double time]){
    drawables.forEach((drawable) => drawable.render(time));
  }
  
  destroy(){
    drawables.forEach((drawable) => drawable.destroy());
    drawables.clear();
  }
  
  addToRenderingCycle(Drawable drawable){
    drawables.add(drawable);
  }
  
  removeFromRenderingCycle(Drawable drawable){
    drawables.removeAt(drawables.indexOf(drawable));
  }
  
  updateRender(double time){
    render(time);
    lastX = x;
    lastY = y;
  }
}
