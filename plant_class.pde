class Plant { //<>//
  MyDot     position;
  int age;    // from the last division
  int ageMax; // age of division
  int ageAll; // age from birth
  int ageDead;// age for death
  int divNum; // number of division
  int mass;
  int size;
  Plant(float x, float y, float z) {
    position = new MyDot(x, y, z);
    age = 0;
    ageMax = 255;
    divNum= 0;
    ageDead = 1024;
    mass = 20;
    size = 2;
  }

  void grow() {
    mass++;
    age++;
    ageAll++;
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    noStroke();
    fill(255 - mass, 255, 255 - mass);

    box(size);
    popMatrix();
  }
}

class PlantField {
  // 
  int num;
  ArrayList <Plant> plantField;
  ArrayList <Plant> plantFieldBuff;
  ArrayList <Plant> buff;
  int maxCellNumber = 4000;
  PlantField(int inum, float x, float y, float z) {
    plantField = new ArrayList<Plant>();
    buff = new ArrayList<Plant>();
    for (int i=0; i < inum; i++)
      plantField.add(new Plant(random(x), random(y), random(z)));
  }

  void grow() {
    plantFieldBuff = new ArrayList <Plant> (plantField);
    for (Plant field : plantFieldBuff) {
      field.grow();
      //Cell dividing
      if (field.ageAll > field.ageDead)
        plantField.remove(field);
      else
        if (((field.age + random(50)) > field.ageMax)&&(plantField.size() < maxCellNumber)) {

          //adding cell's neighborhoods in buffer
          for (Plant field_c : plantField) {
            if ((field.position.len(field_c.position) <= 2 * field.size) && (field.position.len(field_c.position) != 0))
              buff.add(field_c);
          }
          //checking for number of neighborhoods
          if (buff.size() < 9) {
            float theta = PI*random(180)/180;
            float phi = PI*random(360)/180;
            //Creating random vector for a new cell
            MyVector newPos = new MyVector(2 * field.size, theta, phi, 'S');
            float lenMin = 4 * field.size;
            float len;

            // label for breaking bust
            // TODO: implement a special method
          outerloop:
            // Rotating the vector and trying to find free place
            for (float i = 0; i <= PI; i+=PI/2) {
              for (float j = -PI; j <= PI; j+=PI/4) {
                newPos.setRPT(2*field.size, theta + i, phi + j);
                //newPos.rotateVec(i*)
                for (Plant buff_c : buff) {
                  len = sqrt((pow(newPos.x + buff_c.position.x - field.position.x, 2))
                    +(pow(newPos.y + buff_c.position.y - field.position.y, 2))
                    +(pow(newPos.z + buff_c.position.z - field.position.z, 2)));
                  lenMin = (lenMin > len) ? len : lenMin;
                }
                if (lenMin >= 2*field.size) {
                  field.mass /= 4;
                  field.age = 0;
                  field.divNum++;
                  if (field.divNum > 4)
                    plantField.remove(field);
                  // adding new cell into the field
                  plantField.add(new Plant(newPos.x + field.position.x, 
                    newPos.y + field.position.y, 
                    newPos.z + field.position.z));
                  break outerloop; // breaking the loop
                }
              }
            }
            buff.clear();
          } else
            buff.clear();
        }
    }
  }

  void display() {
    for (Plant field : plantField) {
      field.display();
    }
    println("Number of plants: ", plantField.size());
  }
}