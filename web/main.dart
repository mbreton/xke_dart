import 'dart:html';
import 'core/spaceinvader.dart';

Stage stage = null;

void main() {
  // A supprimer
  stage = new Stage.fromCanvas(query('#stage'));
}
