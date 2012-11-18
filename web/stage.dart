part of spaceinvader;

class Stage {
  
  int _currentStateIdx=0;
  set currentStateIdx (int val){
    if (val != _currentStateIdx)
    {
      if (val > states.length-1 || val < 0) return;// throw new UnsupportedError("");
      currentState.destroy();
      _currentStateIdx = val;
      currentState.init();
    }
  }
  
  State get currentState => states[_currentStateIdx];
  List<State> states;
  CanvasElement canvas;
  
  CanvasRenderingContext2D get ctx => canvas.context2d;
  
  Stage.fromCanvas (this.canvas){
    states = new List<State>()
              ..add(new Menu(this))
              ..add(new Playing(this))
              ..add(new GameOver(this));
    currentState.init();
    window.requestAnimationFrame(runLoop);
  }
  
  runLoop (double time){
    currentState.render(time);
    window.requestAnimationFrame(runLoop);
  }
  
  nextState() => currentStateIdx = _currentStateIdx +1;
  previousState() => currentStateIdx = _currentStateIdx -1;
  goToFirtState() => currentStateIdx = 0;
}