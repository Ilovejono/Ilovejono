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