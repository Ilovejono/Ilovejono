class Ball extends Entity{
  boolean released = false;
  boolean held = false;
  int mass = 1;
  PImage img;
  int size = 10;
  
  Ball(int x, int y) {
    super(x, y); 
    int num = (int) random(0,4);
    if (num == 0) img = loadImage("ball.png");
    else if (num == 1) img = loadImage("money.png");
    else if (num == 2) img = loadImage("face1.png");
    else img = loadImage("face2.png");
  }
  
  void stickMouse() {
    location.x = mouseX;
    location.y = mouseY;
  }
  
  void pull() {
    if (released == true) return;
    held = true;
    
  }
  
  void release() {
    if (released == true) return;
    released = true;
    held = false;
    
    PVector mouse = new PVector(mouseX, mouseY);
    PVector loc = new PVector(width/2, height-100);
    PVector dir = PVector.sub(mouse, loc);
    
    dir.mult(-0.16);
    dir.limit(9);
     
    velocity = dir;
    //velocity = new PVector(mag*mag - 
  }
  
  void update() {
    if (held) {
      location.x = mouseX;
      location.y = mouseY;
    }
    else {
      if (released) {
         //apply grav
         applyForce(new PVector(0,0.1));
        
         velocity.add(acceleration);
         location.add(velocity);
         acceleration.mult(0);
      }
    }
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  boolean collideGoal(Goal goal) {
    if (location.x > goal.location.x + 5 
    && location.x < goal.location.x+65 
    && location.y > goal.location.y+20 
    && location.y < goal.location.y+25) return true;
    
    return false;
  }
  
  void draw() {
    // TODO make rotate as you throw it
    //ellipse(location.x, location.y, 20, 20);
    
    if (!released) {
       line(location.x, location.y, width/2, height-100);
    }
    image(img, location.x-size, location.y-size, 40, 40);
  }
}