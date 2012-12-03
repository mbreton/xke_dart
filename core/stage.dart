part of spaceinvaders;

class Stage {
  
  static int width= 600;
  static int height= 400;
  
  int _currentStateIdx=0;
  int fps = 0;
  double lastFpsUpdateTime = 0.0;
  
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
  var publisher;
  List<Drawable> drawables = new List<Drawable>();
  
  CanvasRenderingContext2D get ctx => canvas.context2d;
  
  Stage.fromCanvas (this.canvas){
   initStepFlags();
   if (this.canvas != null){
      publisher = new Publisher ();
      if (hasMethod(publisher,'setScore')){
        publisher.setScore(0);
      }
      resources = new Resources();
      
      states = new List<State>()
          ..add(new Preloading(this))
          ..add(new Menu(this))
          ..add(new Playing(this))
          ..add(new GameOver(this));
      currentState.init();
      window.requestAnimationFrame(runLoop);
      
      if (hasMethod(resources,'loadImages')){
        var future = resources.loadImages();
        if (future != null){ // to avoid NPE
          future.then((images){
            if (images is List){ // to check loadImages state
              images.forEach((image){
                resources.imgs[image.attributes['src']] = image;
              });
              nextState();
            }
          });
        }
      } else{
        resources = new Map<String, Element> ();
      }
    }
  }
  
  runLoop (double time){
    if (lastFpsUpdateTime == 0.0 || (time-lastFpsUpdateTime) >= 1000){
      lastFpsUpdateTime = time;
      query('#fps')
          ..innerHTML= "$fps FPS"
          ..classes= ['label',
             'label-${fps >= 60 ? 'success': fps >= 40 ? 'info': 'important'}'
           ];
      fps=0;
    }
    fps++;
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