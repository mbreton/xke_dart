part of spaceinvader;

class Playing extends State{
  
  const BACKGROUND_PATH= '_/img/space2.png';
  
  Playing(stage) : super(stage);
  
  render(){
    super.render();
    var img = new Element.tag('img');
    img.on.load.add((event){
      context.drawImage(img,0,0);
    });
    img.src = BACKGROUND_PATH;
  }
  
  onKeyPress (KeyboardEvent event){
    // TMP : to test to go to last state
    if (event.charCode == KeyCode.ENTER){ 
      nextState();
    }
  }
}
