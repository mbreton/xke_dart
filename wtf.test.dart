import 'package:/unittest/unittest.dart';

void main() {
  group ("WTF? Dart", (){
    test("doesn't recognize that a function is equals to itself...", () {
      expect(myFunction != myFunction , isTrue);
    });
  });
}

myFunction (){
  print("For more explaination go to http://code.google.com/p/dart/issues/detail?id=144");
}