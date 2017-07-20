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