

Ball current;
Goal goal;
int score = 0;

PFont f;

void setup() {
  size(640,480);
  background(0);
  goal = new Goal(width/2, 150);
  current = new Ball(width/2+10, height - 100+5);
  f = createFont("Arial",32,true);
}

void draw() {
  background(255);
  goal.update();
  current.update();
  goal.draw();
  current.draw();
  fill(0);
  text(str(score), width/2, 20); 
  
  
  if (current.collideGoal(goal)) {
      // make new ball
      current = new Ball(width/2+10, height-100+5);
      score ++;
  }
  
  if (current.location.y > height) {
    current = new Ball(width/2+5, height-95);
    score = 0;
  }
  
  if (current.location.x < 0 || current.location.x > width) {
    current = new Ball(width/2+5, height-95);
    score = 0;}
 
}

void mousePressed() {
  current.pull();
}

void mouseReleased() {
  current.release();
}

class Ball extends Entity{
  boolean released = false;
  boolean held = false;
  int mass = 1;
  PImage img;
  int size = 10;
  
  Ball(int x, int y) {
    super(x, y); 
    int num = (int) random(0,3);
    if (num == 0) img = loadImage("ball.png");
    else if (num == 1) img = loadImage("money.png");
    else if (num == 2) img = loadImage("face1.png");
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

class Entity {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  Entity(int _x, int _y) {
    location = new PVector(_x, _y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  void update() {
    
  }
  
  void draw() {
    
  }
}

class Goal extends Entity {
  
  float moveSpeed;
  PImage img;
  
  Goal(int x, int y) {
    super(x, y);
    moveSpeed = 1;
    velocity = new PVector(moveSpeed, 0);
    img = loadImage("hoop.png");
    
  }
  
  void update() {
    // change location vector
    location.add(velocity);
    
    // reverse direction
    if (location.x > width-70 || location.x < 0) velocity.mult(-1);
  }
  
  void draw() {
    fill(255);
    //ellipse(location.x, location.y, 10,10); 
    image(img, location.x, location.y, 70,40);
  }
  
}