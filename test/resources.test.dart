import 'package:/unittest/unittest.dart';
import 'package:/unittest/html_enhanced_config.dart';

import 'file:/Users/mbreton/workspace/xke_dart/web/core/spaceinvader.dart';
import 'dart:html';

void main() {
  
  useHtmlEnhancedConfiguration();
  
  group ("Resources", (){
    Resources res = new Resources ();
  });
}