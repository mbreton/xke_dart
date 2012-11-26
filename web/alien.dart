part of spaceinvader;

class Alien extends Drawable{
  
  static final height = 30;
  static final width = 30;
  var sens = 1;
  var life = 1;
  var img;
  
  Alien (stage, [x, y]): super(stage, x, y){
    img = res[Images.ALIEN];
  }
  
  render (double time){
    if (x < 0 || x + width > Stage.width){
      x = (x < 0) ? 0 : Stage.width - width;
      y += 40;
      sens *= -1;
    }
    x += (time * 0.4 * sens).toInt();
    context.drawImage(img, x, y);
  }
  
  decreaseLive (){
    life--;
  }
  
  isAlive (){
    return life > 0;
  }
  
  mutate (){
    return new BadAlien.fromAlien(this);
  }
}