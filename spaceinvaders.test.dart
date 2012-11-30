import 'package:/unittest/unittest.dart';
import 'package:/unittest/html_enhanced_config.dart';

import 'core/spaceinvader_lib.dart';
import 'dart:html';
import 'dart:isolate';
import 'package:js/js.dart' as js;

void main() {

  useHtmlEnhancedConfiguration();

  group ("Publisher", (){
    
    test("has a property 'scoreLabel' initialized to \"\" ", (){
      expect(new Publisher().scoreLabel,isNotNull);
    });
    
    test("has a method 'setScore' who take a int in paramaters and return nothing", (){
      var publisher = new Publisher();
      expect(hasMethod(publisher,'setScore'), isTrue);
      expect(publisher.setScore(0), isNull);
    });
    
    test("has a property 'scoreLabel' properly setted when we call 'setScore' with 1", (){
      /**
       * We expect here that you format a string with the score. To help you can use 
       * the string interpolate
       * http://c.dart-examples.com/api/dart-core/interfaces/comparable-hashable-pattern/string
       */ 
      var publisher = new Publisher();
      expect(hasMethod(publisher,'setScore'), isTrue);
      publisher.setScore(1);
      expect(publisher.scoreLabel,equals("1 Point"));
    });
    
    test("has a property 'scoreLabel' properly setted when we call 'setScore' with more than 1", (){
      var publisher = new Publisher();
      expect(hasMethod(publisher,'setScore'), isTrue);
      publisher.setScore(10);
      expect(publisher.scoreLabel,equals("10 Points"));
      
      publisher.setScore(5);
      expect(publisher.scoreLabel,equals("5 Points"));
    });

    test("update correctly the span with a given score", (){
      /**
       * To valid this test call the Javascript function 'updateScoreLabel' defined in the file '_/js/script.js'
       * 
       * To understand how to call a js function from Dart:
       * http://dart-lang.github.com/js-interop/docs/js.html
       * 
       * Once finished, you can see the result on spaceinvaders.html, the red label is initialized with '0 Point'
       */
      // reset the number of call of the js function (used only for assertion)
      js.scoped(() => js.context.nbSetScoreLabel = 0);
      var publisher = new Publisher ();

      publisher.setScore(1);
      js.scoped(() => expect (js.context.nbSetScoreLabel, equals(1)) ); // assert the number of call of JS function
      expect (query('#score').innerHTML, equals('1 Point'));

      publisher.setScore(10);
      js.scoped(() => expect (js.context.nbSetScoreLabel, equals(2)) ); // assert the number of call of JS function
      expect (query('#score').innerHTML, equals('10 Points'));
    });
  });

  group ("Resources", (){

    test("has a 'imgs' map properly initialized", (){
      /**
       * The maps in Dart:
       * http://c.dart-examples.com/learn/variables/maps
       */
      var res = new Resources();
      expect(res.imgs, isNotNull);
      expect(res.imgs is Map, isTrue);
    });

    test("has override '[]' operator to retreive 'Element' type by a 'String' key", (){
      /**
       * In this test you must add [] operator.
       * 
       * How to override operator in Dart
       * http://www.dartlang.org/docs/dart-up-and-running/ch02.html#classes-operators
       * 
       * Not necessary : If your are Chuck Norris you will use the inline closure.
       */
      var res = new Resources();
      var expectedReturn = new Element.tag('span');
      res.imgs['myKey'] = expectedReturn;
      expect (res['myKey'], equals(expectedReturn));
    });

    test("has a method 'loadImages' who return a 'Future' type", (){
     /**
      * In this test you will just declare a method named 'loadImages' who will load all images
      * necessary to draw the game. For the game the loading, we will return a 'Future' type. It's
      * a bit like Java.
      * (reminder :http://docs.oracle.com/javase/1.5.0/docs/api/java/util/concurrent/Future.html)
      * 
      * Documentation about Future in Dart:
      * http://api.dartlang.org/docs/bleeding_edge/dart_core/Future.html
      * 
      */
      var res = new Resources();
      expect(hasMethod (res, 'loadImages'), isTrue);
    });
    
    test("loadImages return a Futur instance of one image loading", (){
      /**
       * Looks Images class in the "core/images.dart", you will 
       * see a method "loadImage" who return a Future instance.
       * 
       * To pass this test simply call method "Images.loadImage"
       * with Images.SHIP in arguments and return the "loadImages".
       */
      var res = new Resources();
      expect(hasMethod (res, 'loadImages'), isTrue);
      
      var future = res.loadImages();
      
      expect(future, isNotNull); // assert the returned value is not null
      future.then((imageLoaded){ // assert that the loaded ImageElement has the "src" attribute that ship image path
        if (imageLoaded is ImageElement)
          expect(imageLoaded.attributes['src'], equals(Images.SHIP));
      });
    });
    
    test("loadImages return a Futur instance of all images loading", (){
      /**
       * Congrats you are just handle your first image loading thanks to Future.
       * The second step now it's to load all Images defined in the Images class.
       * To do that, you will need to use the 'Futures.wait' method. This method
       * acts as a Join/Fork, it's will waiting any Future 
       * to return a global Future of them.
       * 
       * API doc about Futures class :
       * http://api.dartlang.org/docs/bleeding_edge/dart_core/Futures.html
       */
      var res = new Resources();
      expect(hasMethod (res, 'loadImages'), isTrue);
      
      var future = res.loadImages();
      
      expect(future, isNotNull); // assert the returned value is not null
      
      future.then( (imagesLoaded){
        
        /* the future returned by loadImages must return a asynchronous result
         * of type List<ImageElement> now
         */
        expect(imagesLoaded is List<ImageElement>, isTrue);
        
        // build a list of path of loaded images by the 'loadImages' method
        var imagePaths = imagesLoaded.map((image) => image.attributes['src'] );
        
        // assert that all images has been loaded
        expect(imagePaths.length, equals(5));
        expect(imagePaths.contains(Images.SHIP), isTrue);
        expect(imagePaths.contains(Images.ALIEN), isTrue);
        expect(imagePaths.contains(Images.BAD_ALIEN), isTrue);
        expect(imagePaths.contains(Images.PROJECTILE), isTrue);
        expect(imagePaths.contains(Images.SPACE2), isTrue);
      });
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

    test("has 'img' property initialized in the constructor with the correct ImageElement", (){
      /**
       * In each Drawable is injected :
       *  - An instance of Resources accessible by a property called 'resources'
       *  - A 'context' variable of type CanvasRenderingContext2D
       *  - The Stage instance (it contains the width and the height of the area)
       *  - The current x, y position
       *  
       * The core of game have initialised images in resources for you
       * Initialize img with 'resources' property.
       * 
       * Remimber that you can use [] operator with one
       *  of path defined in Images class.
       */ 
      var alien = new Alien (stage, 0, 0);
      expect (alien.img, equals(stage.resources[Images.ALIEN]));
    });
    
    test("override a 'render' method that take in arguments a double", (){
      /**
       * Don't forget to call super.render, if not, you will not see the image!
       */
      var alien = new Alien (stage, 0, 0);
      expect(hasMethod(alien, 'render'), isTrue);
      expect(alien.render(0.0), isNull);// to test type of parameter
    });
    
    test("override render method, and compute x to traverse stage from left to right in 1.5s", (){
      /**
       * At the end, the aliens must cross the stage like that :
       * +=========================+
       * !A----->----->----->-----v!
       * !v-----<-----<-----<------!
       * !------>----->----->-----v!
       * !<-----<-----<-----<------!
       * +=========================+
       * 
       * Firstly we defined that a alien cross the stage in 1,5s.
       * Knowing that 'render' method receive the time 
       * elapsed betwen two of it. Implement the method
       * to change x like expected in the tests.
       * 
       * WARNING : Prefer to place super.render at the end of the method!
       */
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

    test("compute y to step down of 40 when x is out of stage", (){
      var alien = new Alien (stage, 0, 0);
      expect (alien.y, equals(0));

      alien.render(1500.0);
      alien.render(1.0);

      // x should be equal to the width of stage minus the with of the alien
      expect (alien.x, equals(570));
      // y shoud be step down of 40
      expect (alien.y, equals(40));
    });

    test("compute x to go in the other sens when step down", (){
      /**
       * Last test of alien rendering, check your page after to have finished
       * and see the invasion ...
       */
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

    test("has a 'live' property initialized to 1", (){
      var alien = new Alien (stage, 0, 0);
      expect (alien.life , equals(1));
    });

    test("has life equal to zero when we call decreaseLive", (){
      var alien = new Alien (stage, 0, 0);
      alien.decreaseLive();
      expect (alien.life , equals(0));
    });

    test("isAlive return true if alien has yet life", (){
      /**
       * You must implement a getter for this test
       * http://www.dartlang.org/articles/idiomatic-dart/#fields-getters-setters
       */
      var alien = new Alien (stage, 0, 0);
      expect (alien.isAlive , isTrue);
      alien.life =0;
      expect (alien.isAlive , isFalse);
    });
  });

  group('Very Bad Alien', (){

    var stage = new Stage.fromCanvas(new Element.tag('canvas'));

    test("is instiable from an alien and inherit of Alien", (){
      /**
       * For this test you will must inherite of Alien in first time
       * and in second time, create a named constructor.
       * This named construtor named 'fromAlien' shoudld 
       * initialize the VeryBadAlien properties from alien
       * properties, you can find a exameple here:
       * http://c.dart-examples.com/learn/class/constructors/named-constructor
       * And here for handle inheritance of Alien in same time:
       * http://c.dart-examples.com/learn/class/constructors/constructor-inheritance
       */
      var alien = new Alien (stage, 0, 0);
      var badAlien = new VeryBadAlien.fromAlien(alien);
      expect (badAlien is Drawable, isTrue);
    });

    test("has 2 lifes", (){
      var alien = new Alien (stage, 0, 0);
      var badAlien = new VeryBadAlien.fromAlien(alien);
      expect (badAlien.life, equals(2));
    });

    test("has 'img' property initialized with the correct ImageElement", (){
      var alien = new Alien (stage, 0, 0);
      var badAlien = new VeryBadAlien.fromAlien(alien);
      expect (badAlien.img, equals(stage.resources[Images.BAD_ALIEN]));
    });

    test("are created by a mutation of Alien", (){
      /**
       * Comeback on Alien class and implements 
       * a 'mutate' method in return a VeryBadAlien 
       * instance builded from Alien himself thanks
       * to named constructor.
       */
      var alien = new Alien (stage, 11, 22);
      var badAlien = alien.mutate();

      expect (badAlien.stage , equals(stage));
      expect (badAlien.x , equals(11));
      expect (badAlien.y , equals(22));
    });

    test("mutate return VeryBadAlien itself", (){
      /**
       * VeryBadAlien inherite of Alien so you
       * should override 'mutate' method to return
       * the very bad alien itself on its implementation
       * 
       * After that, re-check your game and wait 10sec ... 
       * You see, the situation is worse and worse =D
       */
      var alien = new Alien (stage, 0, 0);
      var badAlien = new VeryBadAlien.fromAlien(alien);
      expect (badAlien.mutate(), badAlien);
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

    test("inherit of Drawable and is instiable", (){
        var ship = new Ship (stage, 0, 0);
        expect (ship is Drawable, isTrue);
    });

    test("has an 'img' property initialized with the correct ImageElement", (){
      var ship = new Ship (stage, 0, 0);
      expect (ship.img, equals(stage.resources[Images.SHIP]));
    });

    test("override a 'render' method that take in arguments a double", (){
      /**
       * Like Alien, don't forget to call super.render
       * 
       * Check the page to see your ship ready to frag! 
       */
      var ship = new Ship (stage, 0, 0);
      expect(hasMethod(ship, 'render'), isTrue);
      expect(ship.render(0.0), isNull);// to test type of parameter
    });

    test("has a 'moveLeft' method to move ship of 10 on left", (){
      var ship = new Ship (stage, 10, 0);
      expect(hasMethod(ship, 'moveLeft'), isTrue);
      ship.moveLeft();
      expect(ship.x, equals(0));
    });

    test("moveLeft move ship of 10 on left but doesn't move outside the stage", (){
      var ship = new Ship (stage, 5, 0);
      expect(hasMethod(ship, 'moveLeft'), isTrue);
      ship.moveLeft();
      expect(ship.x, equals(0));
    });

    test("has a 'moveRight' method to move ship of 10 on right", (){
      var ship = new Ship (stage, 10, 0);
      expect(hasMethod(ship, 'moveRight'), isTrue);
      ship.moveRight();
      expect(ship.x, equals(20));
    });

    test("moveRight method ship of 10 on right but doesn't move outside the stage", (){
      var ship = new Ship (stage, 560, 0);
      expect(hasMethod(ship, 'moveRight'), isTrue);
      ship.moveRight();
      expect(ship.x, equals(600-34));
    });

    test("has a 'fire' method who instanciate a new projectile each time", (){
      /**
       * You can find a Projectile class already implented in the core/projectile.dart file.
       * Instanciate a new Projectile each time that fire is called
       * The projectile must have its x, y correctly initialized in order that
       * the project appear in front of ship.
       */
      var ship = new Ship (stage, 50, 40);
      expect(hasMethod(ship, 'fire'), isTrue);

      // shoot two times
      ship.fire();
      ship.fire();

      var nbProjectileFound = 0;
      stage.drawables.forEach((drawable) {
        if (drawable is Projectile){
          var projectile = drawable as Projectile;
          // each projectile must be instanciate in the middle on the ship
          expect(projectile.x, equals(50+(34/2)));
          // each projectile must be instanciate in front of the ship
          expect(projectile.y, equals(40));

          // count number of projectile in the rendering cycle
          ++nbProjectileFound;
        }
      });

      // check the number of bomb builded
      expect(nbProjectileFound, equals(2));

      // clean ..
      stage.removeAllFromRenderingCycle();
    });

    /**
     * TODO : Find a way to emulate Keyboardevent keyUp
     */
    test("has a 'onKeyUp' method that take in arguments a KeyboardEvent", (){
      var ship = new Ship (stage, 0, 0);
      expect(hasMethod(ship, 'onKeyUp'), isTrue);
    });

    /**
     * TODO : Find a way to emulate Keyboardevent keyUp
     */
    test("has a 'destroy' method which call super.destroy and remove keyboard handler", (){
      var ship = new Ship (stage, 0, 0);
      expect(hasMethod(ship, 'destroy'), isTrue);
    });
  });
}