class Preset14 extends Preset {
  Particle raton;
  Particle raton2;
  Attraction[] atracciones;
  float[] dimensiones;
  ParticleSystem physics; //objeto de clase ParticleSystem
  Particle[] particles; //array de partículas
  traer.physics.Spring[] springs; //array de partículas
  float velocity = 5.0; //velocidad
  float particleSize = 10; //tamaño de partículas
  float attractStrength = 20.0; //fuerza de atraccion
  int particleAmount = 1000; //cantidad de partículas
  boolean attractRepel = false; //repelan las particlas?
  boolean firstMouseClick = false; //primera vez que el mouse hace click?
  float scala = 1; //escala
  Preset14(String _name) {
    super(_name);
    resetWorld(int(random(0, width)), int(random(0, height)));
  }
  public void changeTipo(int tipo) {
    
  }
  public void f_mousePressed() {
    reset();
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };
  public void reset() {
    resetWorld(mouseX, mouseY);
  }
  public void draw() {
    if (super.on) {
      render();
    }
  }
  public void start() {
  }
  public void listener() {
    super.listener();
  }



  private void render() {

    // anclasprings();
    if (BT_11) {
      raton.position().set( super.getX(), super.getY(), 0 );
      raton2.position().set( super.getX()+ATRACCION, super.getY(), 0 );
    }
    physics.tick(SPEED);
    drawParticles(); //draw the particles
  }
  void resetWorld(int x, int y) {
    firstMouseClick = true;
    //make some particles

    createParticles(x, y);
  }  
  void anclasprings() {

    if (BT_11) {
      for ( int i = 1; i < particles.length; ++i )
      {
        springs[i] = physics. makeSpring( particles[i-1], particles[i], 0.05, 0.1, 0.01);
      }
    }
    else
    {
      for ( int i = 1; i < particles.length; ++i )
      {
        physics.removeSpring(springs[i]);
      }
    }
  }
  void createParticles(int x, int y) {
    //create a new physics environment from the Traer physics engine
    physics = new ParticleSystem( 0.010, 0.05 );

    //create an array to hold the particle objects
    dimensiones = new float[particleAmount];
    particles = new Particle[particleAmount];
    springs = new  traer.physics.Spring[particleAmount];
    atracciones = new Attraction[2];
    raton =physics .makeParticle(100.0, 0, height, 0.0);
    raton.makeFixed();
    raton2 =physics .makeParticle(100.0, width, height, 0.0);
    raton2.makeFixed();
    //birth some particle objects
    for (int i = 0; i < particles.length; ++i ) {
      particles[i] = physics.makeParticle( 1.0, random(width), 0, random(-20.0, 20.0) );
      //particles[i].position().set( x, y, 0.0 );
      particles[i].velocity().add( random(-velocity, velocity), random(-velocity, velocity), random(-velocity, velocity));
      atracciones[0] = physics.makeAttraction( particles[i], raton, attractStrength, 50.0 ); 
      atracciones[1] = physics.makeAttraction( particles[i], raton2, attractStrength, 50.0 ); 
      particles[i].setMass(random(0.1, 0.2));
      dimensiones[i] = random(0, 10);
    }
  }
  ///DRAW PARTICLES///
  void drawParticles() {

    noStroke();
    atracciones[0].setStrength(ATRACCION);
    atracciones[1].setStrength(-ATRACCION);
    float direction = 1;
    if ( !isSpring ) {
      direction = -11;
    }

    //beginShape(POINTS);
    for ( int i = 0; i < map(INC,0,256,0,1000); ++i )
    {
      //keep recylcing the particles - if they fall off the bottom of the screen, put them back on top
      if (particles[i].position().y() > height) {
        particles[i].position().set( particles[i].position().x(), -100, 0.0 );
      }
      fill(o_colores.getColor(0), ALFA);
      stroke(o_colores.getColor(0), STROKE_ALFA); // use lower alpha for finer detail 
      //vertex(particles[i].position().x(), particles[i].position().y());


      //  
      noStroke();
      ellipse(particles[i].position().x(),particles[i].position().y(),2,2);
    }
    //endShape();
  }
}