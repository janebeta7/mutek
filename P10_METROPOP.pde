//preset1  > metropop Screen remix
class Preset9 extends Preset {
  boolean initialized = false;
  int NUM_PARTICLES  = 10000;
  int NUM_ATTRACTORS = 3;
  Particle2[] particle;
  Attractor2[] attractor;
  int num, modo;
  Preset9(String _name) {
    super(_name);
    /*--------------------------------------------------------------------*/
    //num = _num;
    reset();
  }
  public void f_mousePressed() {
    reset();
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };
  public void changeTipo(int tipo) {
  }
  public void reset() {
    //NUM_PARTICLES  = int(map(aKNOB[0][0], 0, 127, 0, NUM_PARTICLES));
    attractor = new Attractor2[NUM_ATTRACTORS];
    particle = new Particle2[NUM_PARTICLES];
    scatter(height-50, 100);
    attractor[0] = new Attractor2(100, height-100);
    attractor[1] = new Attractor2(width-100, height-100);
    attractor[2] = new Attractor2(width/2, 100);
    // attractor[3] = new Attractor2(mouseX,mouseY+ATRACCION);
  }
  public void draw() {

    if (super.on) {

      render();
    }
  }

  void render() {
    ATRACCION = map(aKNOB[0][1], 0, 127, 0, 1000);
    if (TIPO == 1 ) tipo1();
    if (TIPO == 2 ) tipo2();
    if (TIPO == 3 ) tipo3();
    if (TIPO ==5 ) tipo4();
    if (TIPO ==5 ) tipo4();
    if (TIPO ==6 ) tipo1();


    if (BT_71) drawLines(); else
   drawPoints();
  }
  void drawPoints() {
 // beginShape(LINES);
int INCP  = int(map(aKNOB[0][0], 0, 127, 0, NUM_PARTICLES));
    for (int i = 0; i < INCP; i++) {
      // stroke(255,ALFA); // use lower alpha for finer detail  
      if (BT_51)      stroke(bg.getColor(int(particle[i].x), int(particle[i].y)), o_sound.getMedia(0, LONG)+map(aKNOB[0][15], 0, 127, 0, 255));
      else stroke(o_colores.getColor(0), o_sound.getMedia(0, LONG)+map(aKNOB[0][7], 0, 127, 0, 255));
      if (BT_51)      fill(bg.getColor(int(particle[i].x), int(particle[i].y)), o_sound.getMedia(0, LONG)+map(aKNOB[0][15], 0, 127, 0, 255));
      else fill(o_colores.getColor(0), o_sound.getMedia(0, LONG)+map(aKNOB[0][7], 0, 127, 0, 255));
    
      // stroke(map(i,i,particle.length,100,255),0,0,20); // use lower alpha for finer detail
      particle[i].step(attractor);
      // 
     // fill(255);
      //ellipse(particle[i].x, particle[i].y,5,5);
      //sacar el vertex punto color
      //noStroke();
        ellipse(particle[i].x,particle[i].y,2,2);
    }
    //endShape();
  }
  
  void drawLines() {
    beginShape(LINES);
int INCP  = int(map(aKNOB[0][0], 0, 127, 0, NUM_PARTICLES));
    for (int i = 0; i < INCP; i++) {
      // stroke(255,ALFA); // use lower alpha for finer detail  
      if (BT_51)      stroke(bg.getColor(int(particle[i].x), int(particle[i].y)), o_sound.getMedia(0, LONG)+map(aKNOB[0][15], 0, 127, 0, 255));
      else stroke(o_colores.getColor(0), o_sound.getMedia(0, LONG)+map(aKNOB[0][7], 0, 127, 0, 255));
      // stroke(map(i,i,particle.length,100,255),0,0,20); // use lower alpha for finer detail
      particle[i].step(attractor);
      // 
      vertex(particle[i].x, particle[i].y);
      //sacar el vertex punto color
      //  point(particle[i].x,particle[i].y);
    }
    endShape();
  }
  void tipo3() {
    if (BT_11) {
      attractor[0] = new Attractor2(ATRACCION, mouseY);
      attractor[1] = new Attractor2(width-ATRACCION, mouseY);
      attractor[2] = new Attractor2(mouseX+ATRACCION, mouseY);
       // attractor[3] = new Attractor2(mouseX,mouseY+ATRACCION);
    }
  }
  void tipo2() {

    attractor[0] = new Attractor2(ATRACCION, mouseY);
    attractor[1] = new Attractor2(width-ATRACCION, mouseY);

  }
  void tipo1() {
    if (BT_11) {
      attractor[0] = new Attractor2(ATRACCION, mouseY);
      attractor[1] = new Attractor2(width-ATRACCION, mouseY);
    }
  }
  void tipo4() {
    if (BT_11) {
      attractor[0] = new Attractor2(ATRACCION, mouseY);
      attractor[1] = new Attractor2(width-ATRACCION, mouseY);
      attractor[2] = new Attractor2(mouseX, mouseY);
    }
  }

  void scatter(float posx, float posy) {
    attractor[0] = new Attractor2(posx, posy);
    attractor[1] = new Attractor2(random(width), random(height));

    // randomise particles
    for (int i = 0; i < particle.length; i++) {
      particle[i] = new Particle2();
    }
  }
}