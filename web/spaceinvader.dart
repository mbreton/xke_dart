part of spaceinvader;

// Write you code in this file

class Publisher {
  
  static updateScore (int score){
    js.scoped(() {
      var scoreLabel = "${score} Point${score > 1 ? 's': ''}";
      js.context.updateScoreLabel(scoreLabel); 
    });
  }
}

class Resources {
  
  var imgs = new Map();
  
  Element operator [] (String path) => imgs[path];
  
  Future loadImages (List<String> paths){
    return Futures.wait( paths.map((path)  => Images.loadImage (path) ))
        ..transform((List<Element> images) => images.forEach((Element image) {
         imgs[image.attributes['src']] = image; 
      })
    );
  }
}
