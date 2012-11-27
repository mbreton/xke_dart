import 'package:/unittest/unittest.dart';
import 'package:/unittest/html_enhanced_config.dart';

import '../web/core/spaceinvader_lib.dart';
import 'dart:html';
import 'dart:isolate';
import 'package:js/js.dart' as js;

void main() {
  
  useHtmlEnhancedConfiguration();
  
  group ("Publisher", (){
    
    /**
     * To valid this test
     *  1. You must format the string like expected in the test thanks to the string interpolate
     *  2. Call the Javascript function 'updateScoreLabel' defined in the file 'script.js' in the 
     *     root of the project 
     * 
     * For more explanation about string interpolate in Dart:
     * http://c.dart-examples.com/api/dart-core/interfaces/comparable-hashable-pattern/string
     * 
     * To understand how to call a js function from Dart:
     * http://dart-lang.github.com/js-interop/docs/js.html
     */ 
    test("update correctly the span with a given score", (){
      
      // reset the number of call of the js function
      js.scoped(() => js.context.nbCall = 0);
      
      Publisher.updateScore(1);
      js.scoped(() => expect (js.context.nbCall, equals(1)) ); // asset the number of call of JS function
      expect (query('#score').innerHTML, equals('1 Point'));
      
      Publisher.updateScore(10);
      js.scoped(() => expect (js.context.nbCall, equals(2)) ); // asset the number of call of JS function
      expect (query('#score').innerHTML, equals('10 Points'));
    });
  });
  
  group ("Resources", (){
    
    /**
     * The maps in Dart:
     * http://c.dart-examples.com/learn/variables/maps
     */
    test("has a 'imgs' map properly initialized", (){
      var res = new Resources();
      expect(res.imgs, isNotNull);
      expect(res.imgs is Map, isTrue);
    });
    
    /**
     * In this test you must just add [] operator, and because you are a killer
     * you will use the inline closure.
     * 
     * How to override operator in Dart
     * http://c.dart-examples.com/learn/operators/operator-override
     */
    test("has override '[]' operator to retreive Element by a String key", (){
      var res = new Resources();
      var expectedReturn = new Element.tag('span');
      res.imgs['myKey'] = expectedReturn;
      expect (res['myKey'], equals(expectedReturn));  
    });
    
    /**
     * In this test you will just declare a method named 'loadImages' who will load all images
     * necessary to draw the game. It take in parameter a list of image path and return a Future
     * like in Java.
     * (reminder :http://docs.oracle.com/javase/1.5.0/docs/api/java/util/concurrent/Future.html)
     * 
     * To declare a list in Dart:
     * http://c.dart-examples.com/api/dart-core/interfaces/iterable/collection/list
     * 
     * Documentation about Future in Dart:
     * http://api.dartlang.org/docs/bleeding_edge/dart_core/Future.html
     * 
     * Note:
     * Temporaly you can return "new Future.immediate(0)" to valid test
     */
    test("has a method named 'loadImages' who "
         "has a List of String named 'paths' "
         "and return a 'Future' type", (){
      var res = new Resources();
      var isLoadImagesExist = hasMethod (res, 'loadImages');
      expect(isLoadImagesExist, isTrue);
      if (isLoadImagesExist){
        List<String> paths = new List();
        var result = res.loadImages(paths);
        expect(result is Future, isTrue);
      }
    });
    
    /**
     * The method loadImages is declared ! Now you must implement it. Hopefully the Images
     * class implement a method called 'loadImage' which return a Future who will be trigger
     * at the end of image loading.
     * The goal now is to wait all images loading and return global Future like a Join-Fork in
     * Java.
     * To help you, you can use the 'Futures' class utility:
     * http://api.dartlang.org/docs/bleeding_edge/dart_core/Futures.html
     * 
     * To build the list of Future from the 'loadImage' calls you can use 
     * the "map" or "forEach" method of Collection API :
     * http://api.dartlang.org/docs/bleeding_edge/dart_core/Collection.html
     * 
     */
    test("loadImages return a Future instance of list", (){
      var res = new Resources();
      var isLoadImagesExist = hasMethod (res, 'loadImages');
      expect(isLoadImagesExist, isTrue);
      if (isLoadImagesExist){
        // Then is used to run after that all asynchronous jobs are ended
        res.loadImages([Images.ALIEN, Images.SHIP]).then((images){
          // we check if the result of all call return a list
          expect(images is List, isTrue);
        });
      }
    });
    
    /**
     * The final step is to save our images in the 'imgs' map, to allow
     * core to retrieve Images from ressource instance.
     * To do that you can use the 'transform' method who will be called just after
     * that all asynchonous job are ended and just before the call of 'then'.
     * 
     * 'transform' will receive a list of Element, you can iterate them with a 
     * 'forEach'. You must use 'myImage.attributes['src']' as key for your map 'imgs'
     * 
     * Doc:
     * http://api.dartlang.org/docs/bleeding_edge/dart_core/Future.html
     * 
     */
    test("loadImages return a Future instance of list", (){
      var res = new Resources();
      var isLoadImagesExist = hasMethod (res, 'loadImages');
      expect(isLoadImagesExist, isTrue);
      if (isLoadImagesExist){
        // Then is used to run after that all asynchronous jobs are ended
        res.loadImages([Images.ALIEN, Images.SHIP]).then((images){
          // we check if the images are saved in the map
          expect(res[Images.ALIEN], isNotNull);
          expect(res[Images.SHIP], isNotNull);
        });
      }
    });
    
  });
  
  group ("Ship", (){
    
    var stage = new Stage.fromCanvas(new Element.tag('canvas'));
    
    test("has a static 'height' property initialized at 25", (){
      expect (Ship.height , equals(25));
    });
    
    test("has a static 'width' property initialized at 34", (){
      expect (Ship.width , equals(34));
    });
    
    test("is instiable and inherit of Drawable", (){
        var ship = new Ship (stage, 0, 0);
        expect (ship is Drawable, isTrue);
    });
    
    /**
     * In each Drawable is injected an instance of Resources accessible by a
     * property called 'resource'. Remimber that you can use [] operator with
     * one of path defined in Images class.
     */
    test("has 'img' property initialized with the correct ImageElement", (){
      var ship = new Ship (stage, 0, 0);
      expect (ship.img, equals(stage.resources[Images.SHIP]));
    });
  });
  
  group ("Alien", (){
   
    var stage = new Stage.fromCanvas(new Element.tag('canvas'));
    
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
      expect (alien.img, equals(stage.resources[Images.ALIEN]));
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
}