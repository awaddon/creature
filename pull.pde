int plantNum = 1000;
int zooNum = 50;
ArrayList<Creature> crs;
PlantField pfl;
Observer obs;
int borderX = 300;
int borderY = 300;
int borderZ = 300;
int obsMode;
int moving;
void createLife(int num){
  crs = new ArrayList<Creature>();
  for(int i = 0; i < num; i++){
    crs.add(new Creature ((float)random(borderX/5, borderX - borderX/5),//x
                          (float)random(borderY/5, borderY - borderY/5),//y
                          (float)random(borderZ/5, borderZ - borderZ/5),//z
                          (float)random(  2, 10),//r
                          (float)random(  1, 20),//m
                          (float)random(  0,  1)));//f
  }
}

void drawBorder(){
  noFill();
  stroke(255);
  //box(borderX,borderY,borderZ);
  line(0,0,0,borderX,0,0);
  line(0,0,0,0,borderY,0);
  line(0,0,0,0,0,borderZ);
}

void settings(){
  //size(800, 800, P3D);
  fullScreen(P3D, 1);
  smooth(2);
  createLife(zooNum);
  pfl = new PlantField(plantNum, borderX, borderY, borderZ);
  obs = new Observer(borderX/2, borderY/2, borderZ/2);
}

void draw(){
text("word", 12, 60);  
  if(obsMode == 0)
    camera(borderX + 50, borderY + 50, borderZ + 50, // eyeX, eyeY, eyeZ
           borderX/2, borderY/2, borderZ/2, // centerX, centerY, centerZ
           1.0, 1.0, -1.0); // upX, upY, upZ
  else{
    //obs.observe();
    if (moving == 1)
      obs.move();
    obs.rotateFOV();
    cursor(CROSS);
    camera(obs.position.x, obs.position.y, obs.position.z, // eyeX, eyeY, eyeZ
           obs.position.x + obs.way.x, obs.position.y + obs.way.y, obs.position.z + obs.way.z, // centerX, centerY, centerZ
           0.0, 1.0, -1.0);
  }
  lights();
  background(0);
  drawBorder();
  pfl.grow();
  pfl.display();
  for (Creature cr : crs) {
    cr.moveBrownian();
    cr.eating(pfl.plantField);
    cr.display();
    cr.checkBorders(borderX, borderY, borderZ);
  }
}

void mouseMoved(){
  //obs.rotateFOV();
}

void keyPressed(){
  if (keyCode == ENTER)
    obsMode = (obsMode == 0) ? 1 : 0;
  if (obsMode == 1)
    moving = 1;
}

void keyReleased(){
  moving = 0;
}


  