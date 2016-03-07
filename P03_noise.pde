class Preset2 extends Preset {
  float[] x, y;
  int[] lifespan;
  float oldX, oldY;
  int accentValue;
  //dashboard variables
  public int particleLength = 120;
  public float textureScale = 0.001;
  public int Hue1 = 240;
  public int Saturation1 = 100;
  public int Brightness1 = 100;
  public int Hue2 = 300;
  public int Saturation2 = 100;
  public int Brightness2 = 100;
  public int backgroundColor = 0;
  public int frameSpeed = 10;

  //other variables
  public int particleCount = 150;
  int generationsPerFrame =50;
  float frameOffset = 0;
  Preset2(String _name) {
    super(_name);
    strokeCap(SQUARE);
    // colorMode (HSB, 360, 100, 100);

    //create matricies
    x = new float[particleCount];
    y = new float[particleCount];
    lifespan = new int[particleCount];
    //  background(0, 0, backgroundColor);
  }
  public void changeTipo(int tipo) {
    
  }
  public void f_mousePressed() {
   
    //frameOffset = random(10.0);
    //textureScale = 0.0005 + random(0.007);
    frameOffset = 10;
    textureScale = 0.0005 ;
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };
  public void reset() {
    particleLength = 120;
    frameOffset = 10;
    textureScale = 0.0005 ;
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
    //primary 
  
      particleLength =int( map(aKNOB[2][0], 0, 127, 0, 57));
      textureScale =   map(aKNOB[2][1], 0, 127, 0, 0.2);
      frameOffset =  map(aKNOB[2][2], 0, 127, 0, 50);
      generationsPerFrame = int(map(aKNOB[2][3], 0, 127, 0, 27));
      // setConsola("textureScale:"+textureScale);
       particleCount = int(map(aKNOB[2][4], 0, 127, 0, 134));;


    particles ();
    //secondary


    // particles (0, 0, accentValue);
  }
  void particles () {
    if (oneColor)
      stroke( o_colores.getColor(0), map(aKNOB[2][7], 0, 127, 0, 255));
    else
      stroke( o_colores.getColor(), map(aKNOB[2][7], 0, 127, 0, 255));
      if (isSound)   {
        stroke( o_sound.getLevel()*pow(FADER_4,2), map(aKNOB[2][7], 0, 127, 0, 255));  
       // getBrush().displayAuto(o_sound.getLevel()*pow(FADER_4,2));
      }
    for (int gen=0; gen < generationsPerFrame; gen++)
    {
      for (int i=0; i < particleCount; i++)
      {
        oldX = x[i];
        oldY = y[i];

        //increment all variables
        x[i] += 20 * (0.5 - noise(x[i]*textureScale, y[i]*textureScale, frameOffset + 0));
        y[i] += 20 * (0.5 - noise(x[i]*textureScale, y[i]*textureScale, frameOffset + 1));
        lifespan[i]--;

        line(oldX, oldY, x[i], y[i]);

        //if a particle has "died", reinitialize it
        if (lifespan[i] < 0)
        {
          x[i] = random(width);
          y[i] = random(height);
        //  particleLength = int( KNOB_1);
          lifespan[i] = (particleLength/2) + int (random(particleLength/2));
        }
      }
    }
  }
}