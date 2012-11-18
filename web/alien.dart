part of spaceinvader;

class Alien extends Drawable{
  
  const IMG_PATH= '_/img/normal-alien.png';
  static const width= 30;
  static const height= 30;
  static const SPEED= 10;
  var img;
  var imgLoaded= false;
  double lastTime = 0.0;
  var name;
  var sens = 1;
  
  Alien(this.name, Stage stage, [num x, num y]) : super(stage, x, y){
    img = new Element.tag('img');
    img.on.load.add((event) =>  imgLoaded=true);
    img.src = IMG_PATH;
  }
  
  init(){
    
  }
  
  render([double time]){
    if (imgLoaded){
      context.drawImage(img,x,y, width, height);
    }
    if (x + width >= 600
        || x < 0){
      sens *= -1;
      y += 40;
    }
    x += 1.5 * sens;//0.05 * (time - lastTime);
    
    lastTime = time; 
  }
  
  destroy (){
  }
  
}