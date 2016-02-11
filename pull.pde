int createNum = 10;
ArrayList<Creature> crs;
PlantField pfl;
int borderX = 400;
int borderY = 400;
int borderZ = 400;

void createLife(int num){
  crs = new ArrayList<Creature>();
  for(int i = 0; i < num; i++){
    crs.add(new Creature ((float)random(200, 400),//x
                          (float)random(200, 400),//y
                          (float)random(-50, 0),//z
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


  