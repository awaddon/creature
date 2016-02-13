class MyVector {
  float x;
  float y;
  float z;
  float r;
  float phi;
  float theta;
  
  
  MyVector(float a, float b, float c, char mode){
    if (mode == 'D'){
      x = a;
      y = b;
      z = c;
      calcRPT();    
    }
    else{
      r     = a;
      phi   = c;
      theta = b;
      calcXYZ();
      
    }
  }
  
  void calcXYZ(){
    x = r*sin(theta)*cos(phi);
    y = r*sin(theta)*sin(phi);
    z = r*cos(theta);
  }
  
  void calcRPT(){
    r = sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2));
    theta = acos(z/r);
    phi = atan(y/x);
  }
  
  void rotateVec(float rtheta, float rphi){
    phi += rphi;
    theta += rtheta;
    if (theta > PI){
      theta -= PI;
      phi -= PI;
    }
    calcXYZ();
  }
  
  void setR (float ir){
    r = ir;
    calcXYZ();
  }
  
  void addR (float ir){
    r += ir;
    calcXYZ();
  }
  
  void setXYZ (float ix, float iy, float iz){
    x = ix;
    y = iy;
    z = iz;
    calcRPT();
  }
  
  void addXYZ (float ix, float iy, float iz){
    x += ix;
    y += iy;
    z += iz;
    calcRPT();
  }
  
  void setRPT(float ir, float itheta, float iphi){
    r     = ir;
    phi   = iphi;
    theta = itheta;
    calcXYZ();
  }
}

class MyDot{
  float x;
  float y;
  float z;
  
  MyDot (float ix, float iy, float iz){
    x = ix;
    y = iy;
    z = iz;
  }
  
  float len(MyDot dot){
    return sqrt(pow((dot.x - x), 2) + pow((dot.y - y), 2) + pow((dot.z - z), 2));
  }
}