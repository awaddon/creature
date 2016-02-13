class Observer{
  MyDot     position;
  MyVector  way;
  MyVector  step;
  Observer(float x, float y, float z){
    position = new MyDot(x, y, z);
    way  = new MyVector(10, 0, 0, 'S');
    step = new MyVector( 1, 0, 0, 'S');
  }
  
  void move(){
    step.phi = way.phi;
    step.theta = way.theta;
    step.calcXYZ();
    switch(key){
      case 'w':
        posAdd();
        break;
      case 's':
        posSub(); 
        break;
      case 'a':
        step.rotateVec(0, -PI/2);
        posAdd();
        break;
      case 'd':
        step.rotateVec(0, PI/2);
        posAdd();
        break;
    }
    println("oserver: ", position.x, ", ", position.y,", ", position.z);
  }
  
  void rotateFOV(){
  
    float dphi = 0;
    float dtheta = 0;
    float dx = width/2 - mouseX;
    float dy = height/2 - mouseY;
    // rotating view vector 
    if (dx > 50)
      dphi = -0.1*PI*(log(dx - 50))/180;
    else
      if (dx < -50)
        dphi = +0.1*PI*(log(-dx + 50))/180;
        
    if (dy > 50)
      dtheta = -0.1*PI*(log(dy - 50))/180;
    else
      if (dy < -50)
        dtheta = +0.1*PI*(log(-dy + 50))/180;
    
    way.rotateVec(dtheta, dphi);
  }
  
  void observe(){
    camera(position.x, position.y, position.z, // eyeX, eyeY, eyeZ
           position.x + way.x, position.y + way.y, position.z + way.z, // centerX, centerY, centerZ
           0.0, 1.0, -1.0);
  }
  
   void posAdd(){
     position.x += step.x;
     position.y += step.y;
     position.z += step.z;
   }
   
   void posSub(){
     position.x -= step.x;
     position.y -= step.y;
     position.z -= step.z;
   }
}
   