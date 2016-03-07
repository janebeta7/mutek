class Preset0 extends Preset {
  Particle raton;
  Attraction[] atracciones;
  ParticleSystem physics; //objeto de clase ParticleSystem
  Particle[] particles; //array de partículas
  traer.physics.Spring[] springs; //array de partículas
  float velocity = 15.0; //velocidad
  float particleSize = 10; //tamaño de partículas
  float attractStrength = 20.0; //fuerza de atraccion
  int particleAmount = 256; //cantidad de partículas
  boolean attractRepel = false; //repelan las particlas?
  PImage particlePic;
  String[] listado = new String[100];
  String directorio;
  boolean firstMouseClick = false; //primera vez que el mouse hace click?
  float scala = 1; //escala
  Preset0(String _name) {
    super(_name);
    loadAssets(dataPath("_01_particles/"));
    reset();
  }
  public void f_mousePressed() {
    if (super.on)   reset();
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };
  void loadAssets(String _directorio) {
    directorio = _directorio;
    listado = assets.readFolder(directorio);
  }
  public void reset() {
    resetWorld(int(random(0, width)), int(random(0, height)));
  }
  public void changeTipo(int tipo) {
    _changeTipo(tipo);
  }

  public void draw() {
    if (super.on) {
      render();
    }
  }
  public void listener() {
    super.listener();
  }
  private void render() {
    if (aBT[0][0]) reset();
    //println("physics:"+physics);
    physics.tick(map(aKNOB[0][1], 0, 127, 0, 10)); //velocidad
    physics.setGravity(map(aKNOB[0][9], 0, 127, 0, 1));
    raton.position().set( super.getX(), super.getY(), 0 );
    drawParticles(); //draw the particles
  }

  void resetWorld(int x, int y) {
    try{
    particlePic = loadImage(listado[tipoParticula]); 
    firstMouseClick = true;
    
    createParticles(x, y);
    }
catch(Exception e) {
    }
}  

  public void _changeTipo (int _tipo) {
    tipoParticula =_tipo;
  }
  void createParticles(int x, int y) {
    physics = new ParticleSystem( 0.005, 0.05 );
    particles = new Particle[particleAmount];
    springs = new  traer.physics.Spring[particleAmount];
    atracciones = new Attraction[particleAmount];
    raton =physics .makeParticle(100.0, width/2, height/2, 0.0);
    raton.makeFixed();

    if (aBT[0][2]) {

      makeCuadricula();
    } else
    {
      for (int i = 0; i < particles.length; ++i ) {
        if (aBT[0][1])  particles[i] = physics.makeParticle(300, mouseX, mouseY, 0);

        else
          particles[i] = physics.makeParticle(300, random(0, width), random(0, height), 0);
        particles[i].velocity().add( random(-velocity, velocity), random(-velocity, velocity), random(-velocity, velocity));
        particles[i].setMass(random(0.1, 3.0));

        attractStrength = map(aKNOB[0][10], 0, 127, 0, 100);
 
        atracciones[i] =  physics.makeAttraction( particles[i], raton, attractStrength, 50);
      }
    }
  }
  void drawParticles() {
    noStroke();
    //int num =int(INC);
    int num = int(map(aKNOB[0][0], 0, 127, 0, LONG));
    for ( int i = 0; i < num; ++i )
    {
      if (particles[i].position().y() > height) {
        particles[i].position().set( particles[i].position().x(), -100, 0.0 );
      }
     atracciones[i].setStrength(attractStrength);
      display(particles[i], i);
    }
  }
  void display(Particle p, int num) {
    if (oneColor) tint(o_colores.getColor(0), map(aKNOB[0][15], 0, 127, 0, 255));
    else
      // tint(o_colores.getColor(), map(aKNOB[0][7], 0, 127, 0, 255));
      tint(o_colores.getColor(), map(aKNOB[0][15], 0, 127, 0, 255));
    float tam = o_sound.get_fft(num)*map(aKNOB[0][3], 0, 127, 0, 10);
    // tam = * map(aKNOB[0][3], 0, 127, 0, 100);
    image( particlePic, p.position().x(), p.position().y(), tam, tam); //actually draw something to the screen where the particles are
  }

  void makeCuadricula() {
    int[]caps = {ROUND, PROJECT, SQUARE};
    strokeWeight(1);
    int cols = 16;
    int rows= 3;
    int xPadding = 150;
    int yPadding = 800;
    float w = (width-xPadding)/cols;
    float h = (height-yPadding)/rows;
    float colSpan = (width-cols*w)/(cols+1);
    float rowSpan = (height-rows*h)/(rows+1);
    float x;
    float y = rowSpan;
    int cont = 0;
    for (int i=0; i<rows; i++) {
      x = colSpan;
      stroke(255);
      for (int j=0, k=0; j<cols; j++) {
        strokeCap(caps[k++]);
        if (k>2) {
          k=0;
        }
       /* line(x, y, x+w, y);
        line(x+w, y, x+w, y+h);
        line(x, y+h, x+w, y+h);
        line(x, y+h, x, y);*/
        particles[cont] = physics.makeParticle(300, x+w/2, y+h/2, 0);
        particles[cont].velocity().add( 0, random(-velocity, velocity), 0);
        particles[cont].setMass(random(0.1, 3.0));
        attractStrength = map(aKNOB[0][10], 0, 127, 0, 100);
        atracciones[cont] =  physics.makeAttraction( particles[cont], raton, attractStrength, 50);


cont ++;
        x += w+colSpan;
      }
      y+=h+rowSpan;
    }
  }
}