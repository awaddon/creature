int createNum = 10;
ArrayList<Creature> crs;
PlantField pfl;
int borderX = 400;
int borderY = 400;
int borderZ = 400;

void createLife(int num){
  crs = new ArrayList<Creature>();
  for(int i = 0; i < num; i++){
    crs.add(new Creature ((float)random(borderX/5, borderX - borderX/5),//x
                          (float)random(borderY/5, borderY - borderY/5),//y
                          (float)random(borderZ/5, borderZ - borderZ/5),//z
                          (float)random(  3, 10),//r
                          (float)random(  1, 20),//m
                          (float)random(  0,  1)/10));//f
  }
}

void settings(){
  size(800, 800, P3D);
  smooth(2);
  createLife(createNum);
  pfl = new PlantField(createNum, borderX, borderY, borderZ);
}

void draw(){

  camera(borderX, borderY, borderZ, // eyeX, eyeY, eyeZ
         borderX/2, borderY/2, borderZ/2, // centerX, centerY, centerZ
         0.0, 1.0, 0.0); // upX, upY, upZ
  
  
  lights();
  background(0);
  pfl.grow();
  pfl.display();
  for (Creature cr : crs) {
    cr.moveBrownian();
    cr.display();
    cr.checkBorders(borderX, borderY, borderZ);
  }
}


  