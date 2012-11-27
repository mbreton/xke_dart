part of spaceinvader;

class BadAlien extends Alien{
  
  var life = 2;
  
  BadAlien.fromAlien (Alien alien) : super(alien.stage, alien.x, alien.y){
    sens = alien.sens;
    img = resources[Images.BAD_ALIEN];
  }
  
  mutate (){
    return this;
  }
}
