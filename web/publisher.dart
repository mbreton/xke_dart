part of spaceinvader;

class Publisher {
  
  static updateScore (int score){// TODO : a vider pour solution
    js.scoped(() {
      var scoreElement = js.context.window.document.getElementById('score');
      scoreElement.innerHTML = "${score} Point${score > 1 ? 's': ''}";
    });
  }
}
