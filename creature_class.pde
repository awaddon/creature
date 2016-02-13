class Creature {
  MyDot     position;
  MyVector  average;
  MyVector  velocity;
  float     size; // Sphere radius
  float     mass;
  float     force; // force to move body
  float     consumption; // move energy consumption 
  MyVector  vForce;

  Creature(float x, float y, float z, float isize, float imass, float iforce) {
    position = new MyDot(x, y, z);
    //average =  new MyVector(avg.x, avg.y, avg.z, 'D');
    size  = isize;
    mass  = imass;
    force = iforce;
    consumption = random(0, 0.5);
    // calculating vector for moving force for this creature in spherical coordinates
    vForce  = new MyVector (iforce, PI*random(180)/180, PI*random(360)/180, 'S');
    average = new MyVector (vForce.x/mass, vForce.y/mass, vForce.z/mass, 'D');
    velocity = new MyVector (0, 0, 0, 'D');
  }

  void moveBrownian() {
    vForce.rotateVec(PI*random(-5, 5)/180, PI*random(-5, 5)/180);
    average.setXYZ(vForce.x/mass, vForce.y/mass, vForce.z/mass);
    //velocity.setR(velocity.r*0.9);
    velocity.addXYZ(average.x, average.y, average.z);
    //velocity.setR(velocity.r*0.999);
    position.x += velocity.x;
    position.y += velocity.y;
    position.z += velocity.z;
    mass -= vForce.r * consumption;
  }

  void checkBorders(float borderX, float borderY, float borderZ) {
    /*
    if (position.x > borderX) position.x = 0;
     if (position.x < 0) position.x = borderX;
     if (position.y > borderY) position.y = 0;
     if (position.y < 0) position.y = borderY;
     if (position.z > borderZ) position.z = 0;
     if (position.z < 0) velocity.z = borderZ;
     */
    if ((position.x < 0)||(position.x > borderX)) {
      velocity.x = -velocity.x/2;
      position.x = (position.x < 0) ? abs(position.x) : (2*borderX - position.x);
    }
    if ((position.y < 0)||(position.y > borderY)) {
      velocity.y = -velocity.y/2;
      position.y = (position.y < 0) ? abs(position.y) : (2*borderY - position.y);
    }
    if ((position.z < 0)||(position.z > borderZ)) {
      velocity.z = -velocity.z/2;
      position.z = (position.z < 0) ? abs(position.z) : (2*borderZ - position.z);
    }
  }

  void eating(ArrayList<Plant> plants){
    ArrayList <Plant> plantsBuff = new ArrayList <Plant> (plants);
    for (Plant plant : plantsBuff){
      if (position.len(plant.position) < (size + plant.size)){
        mass += plant.mass;
        plants.remove(plant);
      }
    }
  }
    



  void display() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    rotateX(velocity.phi);
    rotateZ(velocity.theta);
    fill(64, 64, 255);
    noStroke();
    sphereDetail(10);
    sphere(size);
    translate(0, 0, -size-2);
    fill(255, 0, 0);
    box(2);
    popMatrix();
  }
}