part of spaceinvader;

abstract class Stagable {
  
  Stage stage;
  
  get resources => stage.resources;
  CanvasRenderingContext2D get context => stage.canvas.getContext("2d");
  
  Stagable(this.stage);
  
  init () {}
  render (time){}
  destroy(){}
}
