part of spaceinvader;

class Stage {
  
  int _currentStateIdx=0;
  set currentStateIdx (int val){
    currentState.destroy();
    _currentStateIdx = val;
    currentState.render();
  }
  
  State get currentState => states[_currentStateIdx];
  List<State> states;
  CanvasElement _canvas;
  
  CanvasRenderingContext2D get ctx => _canvas.context2d;
  
  Stage.fromCanvas (this._canvas){
    states = new List<State>()
        ..add(new Menu(ctx))
        ..add(new Playing(ctx))
        ..add(new GameOver(ctx));
  }
  
  nextState(){
    if (_currentStateIdx == states.length-1)
      throw new UnsupportedError("Already on the last state");
    currentStateIdx = _currentStateIdx +1;
  }
  
  previousState(){
    if (_currentStateIdx == 0)
      throw new UnsupportedError("Already on the fisrt state");
    currentStateIdx = _currentStateIdx -1;
  }
  
  goToFirtState(){
    currentStateIdx = 0;
  }
}