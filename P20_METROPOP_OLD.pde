//preset1  > metropop Screen remix
class Preset19 extends Preset {
  boolean initialized = false;
  int NUM_PARTICLES  = 10000;
  int NUM_ATTRACTORS = 3;
  Particle2[] particle;
  Attractor2[] attractor;
  int num,modo;
  Preset19(String _name) {
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
    attractor = new Attractor2[NUM_ATTRACTORS];
    particle = new Particle2[NUM_PARTICLES];
    scatter(height-50,100);
    attractor[0] = new Attractor2(100,height-100);
    attractor[1] = new Attractor2(width-100,height-100);
    attractor[2] = new Attractor2(width/2,100);
    // attractor[3] = new Attractor2(mouseX,mouseY+ATRACCION);
  }
  public void draw() {

    if (super.on) {

      render();
    }
  }

  void render() {

    if (TIPO == 1 ) tipo1();
    if (TIPO == 2 ) tipo3();
    if (TIPO == 3 ) tipo3();
    if (TIPO ==4 ) tipo1();
    if (TIPO ==5 ) tipo3();
    if (TIPO ==6 ) tipo1();
  }
  void tipo3() {
    if (BT_11) {
      attractor[0] = new Attractor2(ATRACCION,mouseY);
      attractor[1] = new Attractor2(width-ATRACCION,mouseY);
        attractor[2] = new Attractor2(mouseX+ATRACCION,mouseY);
      //  attractor[3] = new Attractor2(mouseX,mouseY+ATRACCION);
    }

 
    //stroke(o_colores.getColor(0),ALFA); // use lower alpha for finer detail  
    for (int i = 0; i < particle.length; i++) {
      
      if (BT_51)      fill(bg.getColor(int(particle[i].x),int(particle[i].y)),ALFA);
      else fill(o_colores.getColor(0),STROKE_ALFA);
      particle[i].step(attractor);
      ellipse(particle[i].x,particle[i].y,1,1);
    }
  }
  void tipo2() {
    
      attractor[0] = new Attractor2(ATRACCION,mouseY);
      attractor[1] = new Attractor2(width-ATRACCION,mouseY);
    attractor[2] = new Attractor2(mouseX,mouseY+RADIO);
   
    
       
    float alfa = STROKE_ALFA;
     
    beginShape();
    for (int i = 0; i < particle.length; i++) {
       if (BT_51)      
          stroke(bg.getColor(int(particle[i].x),int(particle[i].y)),alfa); 
     else 
     stroke(o_colores.getColor(0),STROKE_ALFA);
      
      
      //stroke(o_colores.getColor(),STROKE_ALFA+o_sound.getLevel()*2); // use lower alpha for finer detail  
      // stroke(map(i,i,particle.length,100,255),0,0,20); // use lower alpha for finer detail
      particle[i].step(attractor);
      // 
      vertex(particle[i].x,particle[i].y);
      // point(particle[i].x,particle[i].y);
    }
    endShape();
  }
  void tipo1() {
    if (BT_11) {
      attractor[0] = new Attractor2(ATRACCION,mouseY);
      attractor[1] = new Attractor2(width-ATRACCION,mouseY);
    }
    for (int i = 0; i < particle.length; i++) {
     // stroke(255,ALFA); // use lower alpha for finer detail  
      if (BT_51)      stroke(bg.getColor(int(particle[i].x),int(particle[i].y)),STROKE_ALFA);
      else stroke(o_colores.getColor(0),STROKE_ALFA);
      // stroke(map(i,i,particle.length,100,255),0,0,20); // use lower alpha for finer detail
      particle[i].step(attractor);
      // 
      // vertex(particle[i].x,particle[i].y);
      point(particle[i].x,particle[i].y);
    }
    // endShape();
  }


  void scatter(float posx, float posy) {
    attractor[0] = new Attractor2(posx,posy);
    attractor[1] = new Attractor2(random(width),random(height));
 
    // randomise particles
    for (int i = 0; i < particle.length; i++) {
      particle[i] = new Particle2();
    }
  }
}
float damp = 0.00040; // remember a very small amount of the last direction
float accel = 900.0; // move very quickly .-Cuanto mas valor mas despacio, para hacer el magnetico opuesto poner negativo

class Particle2 {

  // location and velocity
  float x,y,vx,vy;

  Particle2() {

    // initiaelise with random pos:
    x = random(width);
    y = random(height);
    /* x = random(width);
     y = random(height);
     */
      accel = SPEED;
    // initialise with random velocity:
    vx = random(-accel/2,accel/2);
    vy = random(-accel/2,accel/2);

  }

  void step(Attractor2[] attractor) {
  accel = KNOB_7 *1000;
    // move towards every attractor 
    // at a SPEED inversely proportional to distance squared
    // (much slower when further away, very fast when close)

    for (int i = 0; i < attractor.length; i++) {

      // calculate the square of the distance 
      // from this particle to the current attractor
      float d2 = sq(attractor[i].x-x) + sq(attractor[i].y-y);

      if (d2 > 0.1) { // make sure we don't divide by zero
        // accelerate towards each attractor
        vx += accel * (attractor[i].x-x) / d2;
        vy += accel * (attractor[i].y-y) / d2;
      }

    }

    // move by the velocity
    if (TIPO == 3){
        float vxx  = map(SPEED,0,400,0,0.9);
      x += vxx;
     y += vy;
    }
    else  if (TIPO == 4){
        float vyy  = map(SPEED,0,400,0,0.9);
      x += vx;
     y += vyy;
    } 
     else  if (TIPO == 5){
        float vyy  = map(SPEED,0,127,0,10);
       
      x += vx;
     y += vyy;
    } 
    else  if (TIPO == 6){
        float vxx  = map(SPEED,0,127,0,10);
       
      x += vxx;
     y += vy;
    }
    else 
    {
       x += vx;
      y += vy;
    }
   

    // scale the velocity back for the next frame
   // float damp = 0.00040;
 
    vx *= damp;
    vy *= damp;

  }

}

// this is basically just a random point

class Attractor2 {
  float x,y;
  Attractor2(float x, float y) {
    this.x = x;
    this.y = y;
  }
  Attractor2() {
    x = random(width);
    y = random(height);
  }
}