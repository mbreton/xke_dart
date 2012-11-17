part of spaceinvader;

class Playing extends State{
  
  const BACKGROUND_PATH= '_/img/space2.png';
  
  Playing(stage) : super(stage){
  }
  
  render(){
    var img = new Element.tag('img');
    img.on.load.add((event){
      context.drawImage(img,0,0);
    });
    img.src = BACKGROUND_PATH;
  }
}
