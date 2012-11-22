import 'package:/unittest/unittest.dart';
import 'package:/unittest/html_enhanced_config.dart';

import 'file:/Users/mbreton/workspace/xke_dart/web/core/spaceinvader.dart';
import 'dart:html';

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
    
    test("can go to the next state and then back to previous state", () {
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