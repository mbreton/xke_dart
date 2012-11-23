part of spaceinvader;

class VeryBadAlien extends Alien{
  
  var live = 2;
  
  VeryBadAlien.fromAlien (Alien alien) : super(alien.stage, alien.x, alien.y){
    sens = alien.sens;
    img = res[Images.BAD_ALIEN];
  }
  
  mutate (){
    return this;
  }
}
