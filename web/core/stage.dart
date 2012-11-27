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
  var resources;
  List<Drawable> drawables = new List<Drawable>();
  var _imagePaths = [Images.SHIP,
                     Images.ALIEN,
                     Images.BAD_ALIEN,
                     Images.MISSILE,
                     Images.SPACE2];
  
  CanvasRenderingContext2D get ctx => canvas.context2d;
  
  Stage.fromCanvas (this.canvas){
   if (this.canvas != null){
      Publisher.updateScore(0);
      resources = new Resources();
      
      states = new List<State>()
          ..add(new Preloading(this))
          ..add(new Menu(this))
          ..add(new Playing(this))
          ..add(new GameOver(this));
      currentState.init();
      window.requestAnimationFrame(runLoop);
      
      if (hasMethod(resources,'loadImages')){
        resources.loadImages(_imagePaths).then((images){
          if (images is List) // to check loadImages state
              nextState();
        });
      } else{
        resources = new Map<String, Element> ();
      }
    }
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
  
  nextState() => currentStateIdx = _currentStateIdx +1;
  previousState() => currentStateIdx = _currentStateIdx -1;
  goToFirtState() => currentStateIdx = 0;
}