part of spaceinvader;

abstract class State extends Drawable{
  
  static const width= 600;
  static const height= 400;
  List<Drawable> drawables;
  
  State(stage) : super(stage){
    drawables = new List<Drawable>();
    x = 0;
    y = 0;
  }
  
  render([double time]){
    drawables.forEach((drawable) => drawable.updateRender(time));
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
  
  nextState () => stage.nextState();
  previousState() => stage.previousState();
}
