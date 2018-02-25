/*
*  Inverse Kinematics
*  464 Robotics 
*  By: Dana Soule 
*/


arm[] link = new arm[2];                    //Array named arm with 2 links
PVector base;                               //places the location of base revolute joint
float L = 400;                              //the lenght of the link
PVector position;                           //Position of object (ball)
PVector velocity;                           //velocity of object movement speed of ball



void setup() {
  size (1200, 1000);                        //defines the dimension of display window width and hight of pixels

  position = new PVector(30, 0);            //inital position of object
  velocity = new PVector(2, 6);             //(x,y) direction of inital movement

  velocity.mult(2);                         //increasews the velocity by (n) times
  link[0] = new arm(100, 100, L, 0);        //sets link at index 0 of the array

  for (int l = 1; l < link.length; l++) {    //arm1 = new link(100, 800, 200, 0);
    link[l] = new arm(link[l-1], L, l);      // arm2 = new link(arm1,200, degrees(-PI/4));
  }
  base = new PVector(width/2, height/2);     //position of the base of the link 1 "(width/2, height/2)' is centerd
}

void draw() {
  background(44);
  noStroke(); 
  fill(#000000);                              //hex code for color black
  ellipse(width/2, height/2, 150, 150);       //(x,y, size, size) 

  //
  int total = link.length;                  
  arm end = link[link.length-1];              //is the last link position 
  end.endEffector(position.x, position.y);    //the end effector will follow the object 
  end.update();


  //All object features 
  position.add(velocity);                       // movement on the object
  noStroke();                                   //no outline around ellipse
  fill(#FF00FF);                                //hex color of ellipse fuchsia
  ellipse(position.x, position.y, 80, 80);

  //changes movement of the object direction 
  //with a bounce in the window
  if (position.x > width || position.x < 0) {  
    velocity.x *= -1;
  }
  if (position.y > height || position.y < 0) {  
    velocity.y *= -1;
  }

  for (int l = total-2; l>=0; l--) {
    link[l].follow(link[l+1]);
    link[l].update();
  }

  link[0].setA(base);                          //sets the base in locked position

  for (int l = 1; l < total; l++) {
    link[l].setA(link[l-1].a2);
  } 
  for (int l = 0; l < total; l++) {
    link[l].show();
  }
}
