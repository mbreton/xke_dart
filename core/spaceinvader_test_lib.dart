library spaceinvaders;

import 'dart:mirrors';

// core classes
part 'images.dart';
part 'projectile.dart';
part 'state.dart';
part 'stagable.dart';
part 'drawable.dart';
part 'stage.dart';
part 'utils.dart';

// states
part 'states/preloading.dart';
part 'states/menu.dart';
part 'states/playing.dart';
part 'states/gameover.dart';

// tp
part '../spaceinvaders.dart';


// really dirty mock
class CanvasElement extends Element{
}
class CanvasRenderingContext2D{
  var fillStyle;
  var font;
  
  drawImage (img,x,y,[w,h]){
    
  }
  
  fillRect(x,y, w,h){
    
  }
  
  fillText (string, x, y){
    
  }
}

class Element{
  var src;
  var attributes = {'src':''};
  
  Element(){
  }
  Element.tag(name){
    
  }
  
  get context2d => getContext("2d");
  
  getContext(String dim){
    return new CanvasRenderingContext2D ();
  }
  
  get on => new On();
}

class On{
  get load => new Event();
  get keyPress => new Event();
  get keyUp => new Event();
}

class Event{
  add (callback){
    callback(new KeyboardEvent());
  }
}

class ImageElement extends Element{
  
}

class Window{
  var on = new On();
  requestAnimationFrame(callback){
    
  }
}
class KeyboardEvent{
  var keyCode;
}
class KeyCode{
  static int SPACE=0;
  static int LEFT=0;
  static int RIGHT=0;
}

var window = new Window();

query (selector){
  return new Element();
}

class JS {
  var context = new Context();
  scoped(callback){
    callback();
  }
}

class Context {
  setScoreLabel(label){
    
  }
}

var js = new JS();