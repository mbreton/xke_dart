library spaceinvader;

import 'dart:html';

part 'state.dart';
part 'menu.dart';
part 'playing.dart';
part 'gameover.dart';

class Stage {
  
  State _currentState;
  CanvasElement _canvas;
  
  CanvasRenderingContext2D get ctx => _canvas.context2d;
  
  State get currentState => _currentState; 
  set currentState (State newState){
    if (newState == null) throw new UnsupportedError("The new state is null");
    
    _currentState.destroy();
    _currentState = newState;
    _currentState.render();
  }
  
  Stage.fromCanvas (this._canvas){
    _currentState = new Menu(ctx);
    var playingState = new Playing(ctx);
    var gamingState = new GameOver(ctx);
    
    _currentState.next = playingState;
    playingState.next = gamingState;
  }
  
  nextState(){
    currentState = _currentState.next;
  }
  
  previousState(){
    currentState = _currentState.previous;
  }
  
  goToFirtState(){
    _currentState.destroy();
    while (_currentState.previous != null){
      _currentState = _currentState.previous;
    }
    _currentState.render();
  }
}