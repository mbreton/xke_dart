part of spaceinvader;

class Preloading extends State{
  
  String dots = "";
  double minElapsedTime = 500.0;
  double lastChange = 0.0;
  
  Preloading(stage) : super(stage){
  }
  
  render(double time){
    super.render(time);
    context.fillStyle = 'white';
    context.font = "24pt Helvetica";
    context.fillText("Loading $dots", 240, 200);
    double elapsedTime = time-lastChange;
    if (lastChange == 0.0 || minElapsedTime <= elapsedTime){
      dots = dots == "" ? "." : 
             dots == "." ? ".." : 
             dots == ".." ? "..." : 
             dots == "..." ? "" : "";
      lastChange = time;
    }
  }
}
