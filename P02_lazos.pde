// ---------------- PARTICLE SYSTEM
float GRAVEDAD = 0.2f;
float DRAG = 0.05f;
float STRENGTH = 0.1f; 
//float DAMPING = 1.1f;
float DAMPING = 0.001f;
float RESTLENGHT =1;
boolean isGRAVITY = false;
//float STRENGTH_POINT = 0.0008f;
float STRENGTH_POINT = 0.4f;   
float DAMPING_POINT = 1.0f;
PImage imgTexture ;
float gravedad = 0;
float sp =0.5f;
class Preset1 extends Preset {


  java.util.Vector tendrils;
  traer.physics.ParticleSystem physics;
  traer.physics.Particle mouse;
  int greyer;
  boolean drawing;
  boolean nothingDrawn;
  color aColor[] = new color[100];
  int cont = 0;
  T3ndril tt;
  Preset1(String _name) {

    super(_name);
    // physics = new traer.physics.ParticleSystem( 0.0f, 0.05f );
    physics = new traer.physics.ParticleSystem( gravedad, DRAG );
    //imgTexture = loadImage("berlin-1.jpg");
    //imgTexture = loadImage("brushes/brush6.png");
    textureMode(NORMAL);
    aKNOB[1][14] = STRENGTH_POINT;
    aKNOB[1][6] = DAMPING;
    aKNOB[1][7] = 127;
    aKNOB[1][2] = sp;
    aKNOB[1][15] = 127;
    mouse = physics.makeParticle();
    mouse.makeFixed();


    tendrils = new java.util.Vector();
    drawing = false;
    greyer = 255;
  }
  public void changeTipo(int tipo) {
  }
  public void reset() {
    if (super.on) {
      cont = 0;
      gravedad = 0f;
      DRAG = 0.05f;
      STRENGTH = 0.1f; 
      //float DAMPING = 1.1f;
      DAMPING = 0.001f;
      RESTLENGHT =1;
      isGRAVITY = false;
      //float STRENGTH_POINT = 0.0008f;

      STRENGTH_POINT = 0.4f;   
      DAMPING_POINT = 1.0f;
      // aKNOB[1][14] = 255;
      physics.clear();
      tendrils = new java.util.Vector();
    }
  }
  public void f_mousePressed() {
    if (super.on) {
      dibujar();
    }
  };
  public void f_mouseDrag() {
    if (super.on) {
      try {
        ((T3ndril)tendrils.lastElement()).addPoint( new Vector3D( mouseX, mouseY, 0 ) );
      }
      catch(Exception e) {

        sendConsola("***************DRAW EXCEPTION LAZOS: "+e.toString()+"\n");
      }
    }
  };
  public void f_mouseReleased() { 
    if (super.on) {
      drawing = false;
    }
  };
  public void draw() {
    if (super.on) {
      render();
    }
  }

  public void listener() {
    super.listener();
  }

  private void render() {
    try {
      if (BT_94) reset();
      if (aBT[1][1]) reset();

      if (aBT[1][0]) mouse.makeFree();  // hace libre la primera particula de seguimiento mouse
      else
        mouse.position().set( mouseX, mouseY, 0 );
      if (aKNOB[1][2] != 0.5) //el principio
        sp = map(aKNOB[1][2], 0, 127, 0, 1); //velocidad
      gravedad = map(aKNOB[1][9], 0, 127, 0, 1); //velocidad
      physics.tick(sp);
      //physics.setGravity(gravedad);





      if ( aBT[1][7])  physics.setGravity(0);
      else  physics.setGravity(gravedad);

      if ( greyer >= 64 )
        greyer *= 0.9;


      drawOldGrey();
    }
    catch(Exception e) {

      sendConsola("***************DRAW EXCEPTION LAZO: "+e.toString()+"\n");
    }
  }
  void borrar() {
    physics = new traer.physics.ParticleSystem( gravedad, 0.05f );

    mouse = physics.makeParticle();
    mouse.makeFixed();

    tendrils = new java.util.Vector();
    drawing = false;
    greyer = 255;
  }
  void dibujar() {
    drawing = true;
    Vector3D v3d = new Vector3D( mouseX, mouseY, 0 );
    tt = new T3ndril( physics, v3d, mouse, o_colores.getColor() );
    tendrils.add(tt );

    if (cont == 100) cont = 0; 
    else cont++;
    aColor[cont] =o_colores.getColor();
    // println("cont:"+cont);
  }
  void drawOldGrey()
  {
    if (BT_51) stroke( 0, map(aKNOB[1][7], 0, 127, 0, 255)); 
    else stroke( 255, map(aKNOB[1][7], 0, 127, 0, 255));



    //dibuja los demas elementos

    // drawElastic( (T3ndril)tendrils.firstElement(), true, 255,255 ,0);

    for ( int i = 0; i < tendrils.size ()-1; ++i )
    {
      T3ndril t = (T3ndril)tendrils.get( i );

      drawElastic( t, false, o_colores.getColor(0), o_colores.getColor(), i);
    }

    // stroke( 255, map(aKNOB[1][7], 0, 127, 0, 255) );

    if ( tendrils.size()-1 >= 0 )
      drawElastic( (T3ndril)tendrils.lastElement(), true, 255, 255, 0);
  }

  void drawElastic( T3ndril t, boolean move, color colorr, color colorr2, int cont)

  {
    // aKNOB[1][9] = 0 ;

    DAMPING_POINT = map(aKNOB[1][6], 0, 127, 1f, 2f);

    if (aKNOB[1][14] != 0.4f) //el principio
      STRENGTH_POINT= map(aKNOB[1][14], 0, 127, -1f, 1f);
    // println("STRENGTH_POINT:"+ STRENGTH_POINT);


    for ( int i = 0; i < t.particles.size ()-1; ++i )
    {
      Vector3D firstPoint = ((Particle)t.particles.get( i )).position();
      Vector3D paraMiElipse1 = ((Particle)t.particles.get( t.particles.size()-1 )).position();
      Vector3D paraMiElipse2 = ((Particle)t.particles.get(0)).position();
      Vector3D firstAnchor =  i < 1 ? firstPoint : ((Particle)t.particles.get( i-1 )).position();
      Vector3D secondPoint = i+1 < t.particles.size() ? ((Particle)t.particles.get( i+1 )).position() : firstPoint;
      Vector3D secondAnchor = i+2 < t.particles.size() ? ((Particle)t.particles.get( i+2 )).position() : secondPoint;

      /*fill(255,0,255);
       ellipse(secondPoint.x(),secondPoint.y(),5,5);*/
      traer.physics.Spring s = (traer.physics.Spring)t.springs.get( i );
      s.setStrength(STRENGTH_POINT);
      s.setDamping( DAMPING_POINT);
      if (BT_13 ) { //MAKE FREE
        physics.removeSpring(s);
      }
      //s.setRestLength(STRENGTH_POINT);

      int indice = i % LONG;


      // noStroke();
      // stroke(0,STROKE_ALFA);
      //curveTightness(0);

      if (!BT_52 && !BT_53) {
        //fill(colorr, ALFA);
        if (oneColor) stroke(0, map(aKNOB[1][13], 0, 127, 0, 255));
        else stroke(255, map(aKNOB[1][13], 0, 127, 0, 255));
        //ellipse(paraMiElipse1.x(), paraMiElipse1.y(), RADIO, RADIO);
        if (aBT[1][2]) fill(o_colores.getColor(), map(aKNOB[1][15], 0, 127, 0, 255));
        else fill(aColor[cont], map(aKNOB[1][15], 0, 127, 0, 255));

        if (move) { // el primero
          // ellipse(firstAnchor.x(), firstAnchor.y(),5,5);

          beginShape(LINES);
            float dist = dist(firstAnchor.x(), firstAnchor.y(), paraMiElipse2.x(), paraMiElipse2.y());
            strokeWeight(constrain(dist, 0, 2));
             if (BT_51)      stroke(bg.getColor(int(firstAnchor.x()), int(firstAnchor.y())), map(aKNOB[1][7], 0, 127, 0, 255));
     else
    
            
            stroke(o_colores.getColor(0), map(aKNOB[1][7], 0, 127, 0, 255));
            fill(o_colores.getColor(0), map(aKNOB[1][7], 0, 127, 0, 255));
            vertex(firstAnchor.x(), firstAnchor.y());
            vertex( secondPoint.x(), secondPoint.y());
            vertex( secondAnchor.x(), secondAnchor.y());
          endShape();
        } else
        {
          curve( firstAnchor.x(), firstAnchor.y(), 
            firstPoint.x(), firstPoint.y(), 
            secondPoint.x(), secondPoint.y(), 
            secondAnchor.x(), secondAnchor.y() );
        }


        if (aBT[1][2]) stroke(0, map(aKNOB[1][13], 0, 127, 0, 255));
        else stroke(255, map(aKNOB[1][13], 0, 127, 0, 255));
        vertex(firstAnchor.x(), firstAnchor.y());
        vertex( secondPoint.x(), secondPoint.y());
        vertex( secondAnchor.x(), secondAnchor.y());
        fill(o_colores.getColor(0), map(aKNOB[1][12], 0, 127, 0, 255));
        stroke(aColor[cont], map(aKNOB[1][13], 0, 127, 0, 255));
        ellipse(firstAnchor.x(), firstAnchor.y(), 5, 5);
      } else if (BT_52)
      {
        float colorrAlfa = (o_sound.get_fft(indice)*pow(FADER_7, 2));
        fill(colorr2, colorrAlfa);
        beginShape();
        vertex(firstAnchor.x(), firstAnchor.y());
        vertex( firstPoint.x(), firstPoint.y());
        vertex(secondPoint.x(), secondPoint.y());
        vertex( secondAnchor.x(), secondAnchor.y());
        endShape(CLOSE);



        if (aBT[1][2]) stroke(255, map(aKNOB[1][1], 0, 127, 0, 255));
        else  if (BT_51)  stroke(0, map(aKNOB[1][1], 0, 127, 0, 255));  
        stroke(o_colores.getColor(0), map(aKNOB[1][1], 0, 127, 0, 255));

        line(secondPoint.x(), secondPoint.y(), secondAnchor.x(), secondAnchor.y());
      }
      if (BT_53) {


        float tam = constrain(o_sound.get_fft(indice)*FADER_7, 0, RADIO);

        if (random(1) > 0.95 ) {
          fill(o_colores.getColor(), map(aKNOB[1][7], 0, 127, 0, 255));
          ellipse(secondPoint.x(), secondPoint.y(), tam, tam);
        }

        if (aBT[1][2]) stroke(255, map(aKNOB[1][1], 0, 127, 0, 255));
        else  if (BT_51)  stroke(0, map(aKNOB[1][1], 0, 127, 0, 255));
        else 
        stroke(o_colores.getColor(0), map(aKNOB[1][1], 0, 127, 0, 255));
        line(secondPoint.x(), secondPoint.y(), secondAnchor.x(), secondAnchor.y());
        /* beginShape();
         texture(imgTexture);
         vertex(firstAnchor.x(), firstAnchor.y());
         vertex( firstPoint.x(), firstPoint.y());
         vertex(secondPoint.x(), secondPoint.y());
         vertex( secondAnchor.x(), secondAnchor.y());
         endShape();*/
      }
    }
  }
}

class T3ndril
{
  java.util.Vector particles;
  java.util.Vector springs;
  traer.physics.ParticleSystem physics;
  public color colorr ;
  Particle thisParticle;
  // T3ndril tt = new T3ndril( physics, v3d, mouse,o_colores.devuelveColores() );
  public T3ndril(traer.physics.ParticleSystem pp, Vector3D firstPoint, traer.physics.Particle followPoint, color colorr )

  {

    particles = new java.util.Vector();
    springs = new java.util.Vector();
    this.colorr = o_colores.getColor();
    //colorr =color(255,0,0);
    //println("NEW T3NDRIL: "+hex(this.colorr));
    physics = pp;
    Particle firstParticle = pp.makeParticle( 1.0f, firstPoint.x(), firstPoint.y(), firstPoint.z() );
    particles.add( firstParticle );
    // makeParticle masa 
    // RESTLENGHT = map(FADER_6,0,255,0.1f,15f);
    physics.makeSpring( followPoint, firstParticle, STRENGTH, DAMPING, RESTLENGHT  );
  }
  public color getColor(  ) {
    println("GetColor: "+hex(this.colorr));
    return this.colorr;
  }
  public void addPoint( Vector3D p )
  {
    thisParticle = physics.makeParticle( 2f, p.x(), p.y(), p.z() );
    springs.add( physics.makeSpring( ((Particle)particles.lastElement()), 
      thisParticle, 
      STRENGTH_POINT, DAMPING_POINT, 
      ((Particle)particles.lastElement()).position().distanceTo( thisParticle.position() ) ) );
    particles.add( thisParticle );
  }
}