import 'package:/unittest/unittest.dart';
import 'package:/unittest/html_enhanced_config.dart';

import 'dart:html';
import '../web/stage.dart';

void main() {
  
  useHtmlEnhancedConfiguration();
  
  group ("State", (){
    
    test("set previous itself when we set a next state", () {
      var state = new State (new CanvasRenderingContext2D.internal());
      var state2 = new State (new CanvasRenderingContext2D.internal());
      state.next = state2;
      expect(state2.previous, equals(state));
    });
  });
}