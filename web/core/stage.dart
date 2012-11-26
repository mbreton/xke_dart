part of spaceinvader;

class Stage {
  
  static int width= 600;
  static int height= 400;
  
  int _currentStateIdx=0;
  set currentStateIdx (int val){
    if (val != _currentStateIdx)
    {
      if (val > states.length-1 || val < 0) return;
      currentState.destroy();
      _currentStateIdx = val;
      currentState.init();
    }
  }
  
  State get currentState => states[_currentStateIdx];
  List<State> states;
  CanvasElement canvas;
  var res;
  List<Drawable> drawables = new List<Drawable>();
  
  CanvasRenderingContext2D get ctx => canvas.context2d;
  
  Stage.fromCanvas (this.canvas){
    res = new ResourceLoader.fromImagePaths([Images.SHIP,
                                     Images.ALIEN,
                                     Images.BAD_ALIEN,
                                     Images.MISSILE,
                                     Images.SPACE2]);
    states = new List<State>()
              ..add(new Menu(this))
              ..add(new Playing(this))
              ..add(new GameOver(this));
    currentState.init();
    window.requestAnimationFrame(runLoop);
  }
  
  runLoop (double time){
    currentState.render(time);
    drawables.forEach((drawable) => drawable.refresh(time));
    window.requestAnimationFrame(runLoop);
  }
  
  addToRenderingCycle(Drawable drawable){
    drawables.add(drawable);
  }
  
  removeFromRenderingCycle(Drawable drawable){
    drawables.removeAt(drawables.indexOf(drawable));
  }
  
  removeAllFromRenderingCycle (){
    drawables.forEach((drawable) => drawable.destroy());
    drawables.clear();
  }
  
  formatPointLabel (){
    return "666 points";
  }
  
  nextState() => currentStateIdx = _currentStateIdx +1;
  previousState() => currentStateIdx = _currentStateIdx -1;
  goToFirtState() => currentStateIdx = 0;
}