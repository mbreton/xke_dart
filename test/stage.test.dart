import 'package:/unittest/unittest.dart';
import 'package:/unittest/html_enhanced_config.dart';

import 'dart:html';
import '../web/stage.dart';

void main() {
  
  useHtmlEnhancedConfiguration();
  
  group ("Stage", (){
    
    test("is initialized with a context 2D", () {
      var stage = new Stage.fromCanvas (new CanvasElement());
      expect(stage.ctx, isNotNull);
    });
    
    test("has three states", () {
      var stage = new Stage.fromCanvas (new CanvasElement());
      expect(stage.currentState, isNotNull);
      stage.nextState();
      stage.nextState();
      expect(stage.nextState, throwsA(new isInstanceOf<UnsupportedError>()));
    });
    
    test("can go to the next state and then back to return on the orginial state", () {
      var stage = new Stage.fromCanvas (new CanvasElement());
      var state = stage.currentState;
      stage.nextState();
      stage.previousState();
      expect(stage.currentState, equals(state));
    });
    
    test("can back to the first state", () {
      var stage = new Stage.fromCanvas (new CanvasElement());
      var state = stage.currentState;
      stage.nextState();
      stage.nextState();
      stage.goToFirtState();
      expect(stage.currentState, equals(state));
    });
    
  });
}