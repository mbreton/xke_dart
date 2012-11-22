part of spaceinvader;

abstract class Stagable {
  
  Resources res = new Resources();
  Stage stage;
  CanvasRenderingContext2D get context => stage.canvas.getContext("2d");
  
  Stagable(this.stage);
  
  init () {}
  render (time){}
  destroy(){}
}
