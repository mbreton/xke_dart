part of spaceinvaders;

class Playing extends State{
  
  const MIN_ELAPSED_TIME_BETWEEN_ALIEN_SPWANING = 600;
  const DURATION_TO_MUTATE_ALIEN = 10000;
  
  double lastTime = 0.0;
  double lastTimeAlienSpawning = 0.0;
  double timeSinceMutation= 0.0;
  List<Alien> aliens;
  Ship ship;
  int score=0;
  var background;
  
  Playing(stage) : super(stage){
    
  }
  
  destroy(){
    ship.destroy();
    ship = null;
    super.destroy();
  }
  
  init (){
    aliens = new List ();
    if (flags.contains('shipIsInstanciable')){
      ship = new Ship (stage, (width/2-Ship.width).toInt(), height-Ship.height);
      stage.addToRenderingCycle(ship);
    }
    background = resources[Images.SPACE2];
    score = 0;
    publisher.setScore(score);
  }
  
  render(time){
    context.drawImage(background, 0, 0, width, height);
    
    if (flags.contains('alienIsInstanciable')){
      var timeSinceAlienSpawning = time - lastTimeAlienSpawning;
      if (timeSinceAlienSpawning > MIN_ELAPSED_TIME_BETWEEN_ALIEN_SPWANING){
        lastTimeAlienSpawning = time;
        Alien alien = new Alien (stage, 0, 0);
        aliens.add(alien);
        stage.addToRenderingCycle(alien);
      }
      
      timeSinceMutation += time- lastTime;
      if (timeSinceMutation >= DURATION_TO_MUTATE_ALIEN){
        timeSinceMutation = 0.0;
        List<Alien> newAliens = new List();
        
        aliens.forEach( (alien) {
          if (hasMethod(alien,'mutate')){
            newAliens.add(alien.mutate());
            stage.removeFromRenderingCycle(alien);
          }
        });
        
        newAliens.forEach((veryBadAlien){
          stage.addToRenderingCycle(veryBadAlien);
        });
        aliens = newAliens;
      }
      stage.drawables.forEach((drawable){
        if (drawable is Projectile){
          aliens.forEach( (Alien alien) {
            if ((drawable as Projectile).hasCollisionWith(alien)){
              drawable.destroy();
              alien.decreaseLive();
              if (!alien.isAlive){
                alien.destroy();
                aliens.removeAt(aliens.indexOf(alien));
                score += 10;
              }
            }
          });
        }
      });
      aliens.forEach( (Alien alien) {
        if (alien.y + Alien.height > Stage.height){
          stage.nextState();
        }
      });
      lastTime = time;
      publisher.setScore (score);
    }
  }
}
