part of spaceinvader;

abstract class State extends Drawable{
  
  static const width= 600;
  static const height= 400;
  
  State(stage) : super(stage){
    drawables = new List<Drawable>();
    x = 0;
    y = 0;
  }
  
  render([double time]){
    drawables.forEach((drawable) => drawable.updateRender(time));
  }
  
  nextState () => stage.nextState();
  previousState() => stage.previousState();
}
