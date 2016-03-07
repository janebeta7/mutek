class Preset15 extends Preset {
  float x[],y[];
  float speed[];
  color col[];
  int num_lineas = LONG;
  Preset15(String _name) {
    super(_name);
    
  }
   public void changeTipo(int tipo) {
    
  }
  public void draw() {
    if (super.on) {
      render();
    }
  }
  public void f_mousePressed() {
    reset();
  };
  public void f_mouseDrag() {
  };
  public void f_mouseReleased() {
  };
  public void reset() {
    //iniciar1();
   if (TIPO == 1 ) iniciar1();
    if (TIPO == 2 ) iniciar2();
    if (TIPO > 2 ) iniciar2();
   
  }
  public void listener() {
    super.listener();
  }
  private void iniciar1() {
    x=new float[256];
    y=new float[256];
    col=new color[256];
    speed=new float[256];
    for(int i=0; i<num_lineas; i++) {
      x[i]=0;
      y[i]=random(height);
      if (!oneColor) col[i]= o_colores.getColor();
      else col[i]= o_colores.getColor(0);
      speed[i] =random(4);  // All stripes have a random positive speed
    }
  }
  private void iniciar2() {
    x=new float[256];
    y=new float[256];
    col=new color[256];
    speed=new float[256];
    for(int i=0; i<num_lineas; i++) {
      x[i]=random(width);
      ;
      y[i]=0;
      if (!oneColor) col[i]= o_colores.getColor();
      else col[i]= o_colores.getColor(0);
      speed[i] =random(4);  // All stripes have a random positive speed
    }
  }
  private void render() {
    if (TIPO == 1 ) tipo1();
    if (TIPO == 2 ) tipo2();
    if (TIPO > 2 ) tipo2();
  }
  void tipo1() {
    int num = int(map(INC,0,256,0, LONG));
    for(int i=0; i<num; i++) {
      fill(col[i],KNOB_5);
      noStroke();
      rectMode(CORNER);
      checkBorders(i);
      if (BT_51) fill(col[i],o_sound.getLevel()*pow(KNOB_5,2));
      else fill(col[i],KNOB_5);
      y[i]+=speed[i]-SPEED;
      rect(x[i],y[i]-o_sound.get_fft(i)*FADER_5,width,o_sound.get_fft(i)*FADER_5,height);
    }
  }

  void checkBorders(int i) {
    //println("i:"+i);
    if (y[i] > height+20) y[i] = -20;
    if (y[i] < -20) y[i] = height+20;
    if (x[i] > width+20) x[i] = -20;
    if (x[i] < -20) x[i] =width+20;
  }
  void tipo2() {
    int num = int(map(INC,0,256,0, LONG));
    for(int i=0; i<num; i++) {
      // fill(255,o_sound.getLevel()*STROKE_ALFA);
      fill(col[i],o_sound.getLevel()*KNOB_5);
      if (BT_51) fill(col[i],o_sound.getLevel()*pow(KNOB_5,2));
      else fill(col[i],KNOB_5);
     
      noStroke();
      rectMode(CORNER);
      checkBorders(i);
      x[i]+=speed[i]-SPEED;
      // rect(x[i],y[i]-(o_sound.get_fft(i)*VOLUMEN),width,(o_sound.get_fft(i))*VOLUMEN);
      rect(x[i]-(o_sound.get_fft(i)*FADER_5),y[i],(o_sound.get_fft(i))*FADER_5,height);
    }
  }
}