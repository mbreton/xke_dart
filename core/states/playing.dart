part of spaceinvaders;

class Playing extends State{
  
  const MIN_ELAPSED_TIME_BETWEEN_ALIEN_SPWANING = 600;
  const DURATION_TO_MUTATE_ALIEN = 10000;
  
  double lastTimeAlienSpawning = 0.0;
  double lastTimeAlienMutation = 0.0;
  List<Alien> aliens;
  Ship ship;
  int score=0;
  var background;
  
  Playing(stage) : super(stage);
  
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
    lastTimeAlienSpawning = 0.0;
    lastTimeAlienMutation = 0.0;
  }
  
  render(time){
    context.drawImage(background, 0, 0, width, height);
    
    // init if necessary
    if (lastTimeAlienMutation == 0) lastTimeAlienMutation = time;
    if (lastTimeAlienSpawning == 0) lastTimeAlienSpawning = time;
       
    // count time since events
    var timeSinceMutation = time - lastTimeAlienMutation;
    var timeSinceAlienSpawning = time - lastTimeAlienSpawning;
    
    // alien spwaning
    if (flags.contains('alienIsInstanciable')){
      if (timeSinceAlienSpawning > MIN_ELAPSED_TIME_BETWEEN_ALIEN_SPWANING){
        lastTimeAlienSpawning = time;
        Alien alien = new Alien (stage, 0, 0);
        aliens.add(alien);
        stage.addToRenderingCycle(alien);
      }
    }
    
    aliens.forEach( (Alien alien) {
      // if an alien step under stage, it's a game over
      if (alien.y + Alien.height > Stage.height){
        stage.nextState();
        return;
      }
      
      // aliens mutation
      if (flags.contains('alienIsInstanciable')){
        if (timeSinceMutation >= DURATION_TO_MUTATE_ALIEN){
          lastTimeAlienMutation = time;
          
          if (hasMethod(alien,'mutate')){
            alien.destroy();
            var vbAlien = alien.mutate();
            aliens[aliens.indexOf(alien)] = vbAlien;
            stage.addToRenderingCycle(vbAlien);
          }
        }
      }
      
      // apply damages on the aliens
      stage.drawables.forEach((drawable){
        if (drawable is Projectile){
          if ((drawable as Projectile).hasCollisionWith(alien)){
            drawable.destroy();
            alien.decreaseLive();
            if (!alien.isAlive){
              alien.destroy();
              aliens.removeAt(aliens.indexOf(alien));
              score += 10;
            }
          }
        }
      });
    });
    
    // update score ...
    publisher.setScore (score);
  }
}
