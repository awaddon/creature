class HerbivoraBinome {
  ArrayList <Creature> binome;
  ArrayList <Creature> binomeBuff;

  HerbivoraBinome (int num, float x, float y, float z) {
    binome = new ArrayList<Creature>();
    binomeBuff = new ArrayList<Creature>();
    for (int i = 0; i < num; i++) {
      binome.add(new Creature ((float)random(x/5, x - x/5), //x
        (float)random(y/5, y - y/5), //y
        (float)random(z/5, z - z/5), //z
        (float)random(  1, 10), //r
        (float)random(  1, 20), //m
        (float)random(  0, 1)));//f
    }
  }

  void cycle() {
    for (Creature cr : binome) {
      cr.moveBrownian();
      cr.eating(pfl.plantField);
      cr.display();
      cr.checkBorders(borderX, borderY, borderZ);
      //divide();
      //death();
    }
  }

  void divide() {
    binomeBuff = new ArrayList <Creature> (binome);
    for (Creature cr : binomeBuff) {

      if (cr.mass < 0)
        binome.remove(cr);
      else {
        if (cr.mass > cr.divideMass) {
          cr.mass /= 2;

          Creature newCr = new Creature(cr.position.x+cr.size, 
                                        cr.position.y, 
                                        cr.position.z, 
                                        (cr.size > 1) ? (cr.size + random(-0.5, 0.5)) : (cr.size+random(-0.5*cr.size, 0.5)), 
                                        cr.mass, 
                                        cr.force*random(0.9, 1.1));

          newCr.consumption = cr.consumption * random(0.9, 1.1);
          newCr.divideMass  = cr.divideMass * random(0.9, 1.1);
          binome.add(newCr);
        }
      }
    }
  }

  
}