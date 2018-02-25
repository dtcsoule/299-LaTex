class arm {
  PVector a1 = new PVector();        //position of the base link with revolute joint
  float angle = 0;                   //setting start angle at 0 degrees 
  float l;                           //length of arm
  PVector a2 = new PVector();        //position of the conecting revolute joint

  //constructor for the first arm link
  arm(float x, float y, float len, float q) {    
    a1.set(x, y);
    l = len;
    angle = q; 
    calcB();
  }
  //constructor for the following arm link(s)
  arm(arm parent, float len, float q) {
    a1 = parent.a2.copy();
    l = len;
    angle = q;  
    calcB();
    //follow(parent.a.x, parent.a.y);
  }

  void follow(arm child) {
    float targetX = child.a1.x; 
    float targetY = child.a1.y;
    endEffector(targetX, targetY);
  }
  /*
* The next three blocks are the inverse kinematics 
   */
  void endEffector(float objectx, float objecty) {
    PVector object = new PVector(objectx, objecty);
    PVector direction = PVector.sub(object, a1);
    angle = direction.heading();                   //heading in this function uses inverse tan
    direction.setMag(l);
    direction.mult(-1);
    a1 = PVector.add(object, direction);
  }

  //sets a1 to copy what a2 end position is doing 
  void setA(PVector position) {
    a1 = position.copy(); 
    calcB();
  }  

  //changes the angle with respect to the movement of dx,dy
  void calcB() {
    float dx = l * cos(angle);        
    float dy = l * sin(angle);        
    a2.set(a1.x+dx, a1.y+dy);
  }

  void update() {
    calcB();
  }

  // The Links physical properties
  void show() {
    stroke(255, 200);                 //Link color
    strokeWeight(50);                 //Link thickness
    line(a1.x, a1.y, a2.x, a2.y);     //Position of links
  }
}