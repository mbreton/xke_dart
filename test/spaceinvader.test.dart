import 'package:/unittest/unittest.dart';
import 'package:/unittest/html_enhanced_config.dart';

import '../web/core/spaceinvader.dart';
import 'dart:html';
import 'dart:isolate';
import 'package:js/js.dart' as js;

void main() {
  
  useHtmlEnhancedConfiguration();
  
  group ("Publisher", (){
    
    /**
     * To pass this test :
     *  - you must implement string format, thanks to string interpolate
     *  - you must retreive an element with 'score' for id, and fill its content
     *  
     *  Note:
     *  To retrieve an HTML element in HTML call : window.document.getElementById('myId');
     *  To set content in a HTML element, use : myElement.innerHTML = "myContent" 
     * 
     * For more explanation about string interpolate in Dart:
     * http://c.dart-examples.com/api/dart-core/interfaces/comparable-hashable-pattern/string
     * 
     * For understand how to call a js function from Dart:
     * http://dart-lang.github.com/js-interop/docs/js.html
     */ 
    test("update correctly the span with a given score", (){
      
      Publisher.updateScore(1);
      expect (query('#score').innerHTML, equals('1 Point'));
      
      Publisher.updateScore(10);
      expect (query('#score').innerHTML, equals('10 Points'));
    });
  });
  
  group ("Resources", (){
    
    test("load an image", (){
      var res = new ResourceLoader.fromImagePaths([Images.ALIEN]);
      var timer = new Timer(500, (timer) {
        expect(res[Images.ALIEN], isNotNull);
      });
    });
    
    test("load many images", (){
      var res = new ResourceLoader.fromImagePaths([Images.ALIEN, Images.BAD_ALIEN]);
      var timer = new Timer(500, (timer) {
        expect(res[Images.ALIEN], isNotNull);
      });
    });
  });
  
  group ("Alien", (){
    
    var stage = new Stage.fromCanvas(new Element.tag('canvas'));
    var resources = new ResourceLoader.fromImagePaths([(Images.ALIEN)]);
    stage.res = resources;
    
    test("has a static 'height' property initialized at 30", (){
      expect (Alien.height , equals(30));
    });
    
    test("has a static 'width' property initialized at 30", (){
      expect (Alien.width , equals(30));
    });
    
    test("is instiable and it inherit of Drawable", (){
        var alien = new Alien (stage, 0, 0);
        expect (alien is Drawable, isTrue);
    });
    
    test("has 'img' property initialized with the correct ImageElement", (){
      var alien = new Alien (stage, 0, 0);
      expect (alien.img, equals(resources[Images.ALIEN]));
    });
    
    test("implements render method, and compute x to traverse stage from left to right in 1.5s", (){
      var alien = new Alien (stage, 0, 0);
      expect (alien.x, equals(0));
      
      // During 100ms an alien should crossed 40px
      alien.render(100.0);
      expect (alien.x, equals(40));
      
      // During 100+400ms an alien should crossed 40+160px
      alien.render(400.0);
      expect (alien.x, equals(200));
      
      // During 100+400+1000ms an alien should crossed 40+160+400px
      alien.render(1000.0); 
      expect (alien.x, equals(600));
    });
    
    test("implements render method, and compute y to step down of 40 when x is out of stage", (){
      var alien = new Alien (stage, 0, 0);
      expect (alien.y, equals(0));
      
      alien.render(1500.0);
      alien.render(1.0);

      // x should be equal to the width of stage minus the with of the alien
      expect (alien.x, equals(570));
      // y shoud be step down of 40
      expect (alien.y, equals(40));
    });
    
    test("implements render method, and compute x to go in the other sens when step down", (){
      var alien = new Alien (stage, 0, 0);
      
      // go to right border
      alien.render(1500.0);
      expect (alien.x, equals(600));
      
      // come back to center
      
      // continue to comeback ...
      alien.render(1500.0);
      alien.render(1.0);
      expect (alien.x, equals(0));
    });
    
    test("has a 'mutate' method who return a BadAlien instance builded from Alien himself", (){
      var alien = new Alien (stage, 11, 22);
      var badAlien = new BadAlien.fromAlien(alien);
      
      expect (badAlien.stage , equals(stage));
      expect (badAlien.x , equals(11));
      expect (badAlien.y , equals(22));
    });
    
    test("has a 'live' property initialized to 1", (){
      var alien = new Alien (stage, 0, 0);
      expect (alien.life , equals(1));
    });
    
    test("has life equal to zero when we call decreaseLive", (){
      var alien = new Alien (stage, 0, 0);
      alien.decreaseLive();
      expect (alien.life , equals(0));
    });
    
    test("are dead when his life is equal to zero", (){
      var alien = new Alien (stage, 0, 0);
      expect (alien.isAlive() , isTrue);
      alien.life =0;
      expect (alien.isAlive() , isFalse);
    });
  });
  
  group ("Ship", (){
    
    var stage = new Stage.fromCanvas(new Element.tag('canvas'));
    var resources = new ResourceLoader.fromImagePaths([(Images.ALIEN)]);
    stage.res = resources;
    
    test("has a static 'height' property initialized at 25", (){
      expect (Ship.height , equals(25));
    });
    
    test("has a static 'width' property initialized at 34", (){
      expect (Ship.width , equals(34));
    });
    
    test("is instiable and it inherit of Drawable", (){
        var ship = new Ship (stage, 0, 0);
        expect (ship is Drawable, isTrue);
    });
    
    test("has 'img' property initialized with the correct ImageElement", (){
      var ship = new Ship (stage, 0, 0);
      expect (ship.img, equals(resources[Images.SHIP]));
    });
  });
}