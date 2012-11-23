part of spaceinvader;

class Alien extends Drawable{
  
  static num width= 30;
  static num height= 30;
  static const SPEED= 2.7;
  var sens = 1;
  var live = 1;
  var img;
  
  Alien(Stage stage, [num x, num y]) : super(stage, x, y){
    img = res[Images.ALIEN];
  }
 
  render(time){
    context.drawImage(img, x, y);
    if (x + width >= Stage.width || x < 0){
      sens *= -1;
      y += 50;
    }
    x += SPEED * sens;
  }
  
  mutate (){
    return new VeryBadAlien.fromAlien(this);
  }
  
  decreaseLive (){
    live--;
  }
  
  isAlive (){
    return live > 0;
  }
}