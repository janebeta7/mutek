class Preset18 extends Preset {
  int x_offset = 0; //Left and right padding size
  int default_y = 0; //Base Y size
  int default_z = 0; //Base Z Size
  float scale_y = 100; //Y size multiplies
  float scale_z = 0; //Z size multiplier
  int default_recession = 0; //Z reecession
  boolean symm = true; //Mirror frequencies with memory
  boolean fade = true; //Fade with memory
  int frame_drop = 5; //5 is cool
  int memory_length = 1; //Number of overlapping frames drawn to screen
  float[][] memory; //FFT data, stored for 
  float[] weighting; //Ajust for precieved sound levels
  float thres = 0; //2 is cool
  color bgr_color = color(0, 0, 0);
  color forground_color = color(255, 255, 255);
  PImage img;
  PImage m;
  boolean dibujando = false; //esta variable controla si estamos dibujando la foto o no
  String nombreImagen = "backgroundny.jpg";  
  Preset18(String _name) {


    super(_name);
    reset();
  }
  public void f_mousePressed() {
  };
  public void f_mouseDrag() {

    // dibujaImagen();
  };
  public void changeTipo(int tipo) {
    
  }
  public void f_mouseReleased() {
  };
  public void reset() {
    img = loadImage(nombreImagen); 
    memory = new float[memory_length][LONG];
  }
  public void draw() {
    if (super.on) {
      render();
    }
    //if (BT_51) dibujaImagen();
  }
  public void listener() {
    super.listener();
  }
  void dibujaImagen() {
    int altoRectangulo = 100; //altoRectangulo del dibujo de la foto
    dibujando = true;
    //creamos un rectangulo que serï¿½ el que dibuje la fotografia. Depende de la variable
    //altoRectangulo
    int xstart = 0;
    int ystart = constrain(mouseY-altoRectangulo/2, 0, img.height);
    int xend = img.width;
    int yend = constrain(mouseY+altoRectangulo/2-10, 0, img.height);


    loadPixels();
    // recorremos el area del rectangulo y sacamos su color para rellenarlo despues
    for (int x = xstart; x < xend; x++) {
      for (int y = ystart; y < yend; y++ ) {
        int loc = x + y*img.width;
        float r, g, b;
        r = red (img.pixels[loc]);
        g = green (img.pixels[loc]);
        b = blue (img.pixels[loc]);  
        float d = dist(x, y, mouseX, mouseY);
        color c = color(r, g, b);
        pixels[loc] = c;
      }
    }
    updatePixels();
  }
  private void render() {
    memoria();
    //Here we have OpenGL alpha interference, this could be solve by Z-axis sorting ... for now we'll stick to these options
    //for(int k = memory_length-1;k >= 0;k--) {  //Better for recession
    for (int k = 0;k < memory_length;k++) {   //Better For Overlap
      if (k%frame_drop == 0) {
        if (!fade || k==0) { 
          stroke(o_colores.getColor(), KNOB_5);
          fill(o_colores.getColor(), STROKE_ALFA);
        } 
        else {
          stroke(forground_color, STROKE_ALFA);
          fill(forground_color, KNOB_5);
        }

        float scale_x =map(KNOB_3, 0, 360, -10, 10);
        for (int i = 0;i < LONG;i++) {    
          if (TIPO ==1 ) tipo1(i,k);
          else if (TIPO ==2 ) tipo2(i,k);
          else tipo1(i,k);
        }
      }
    }
  }
  void tipo1(int i,int k) {
    if (oneColor)   fill(o_colores.getColor(0), ALFA); 
    else fill(o_colores.getColor(), ALFA);
    ellipse((float)(width-x_offset*2)/(LONG-1)*i+x_offset, (float)height/2+default_y+(memory[k][i])*scale_y, memory[0][i]*KNOB_3, memory[0][i]*KNOB_3);
    ellipse((float)(width-x_offset*2)/(LONG-1)*i+x_offset, (float)height/2-default_y-(memory[k][i])*scale_y, memory[0][i]*KNOB_3, memory[0][i]*KNOB_3);
    stroke(o_colores.getColor(), STROKE_ALFA);
    line((float)(width-x_offset*2)/(LONG-1)*i+x_offset, (float)height/2+default_y+(memory[k][i])*scale_y, (float)(width-x_offset*2)/(LONG-1)*i+x_offset, (float)height/2-default_y-(memory[k][i])*FADER_3);
  }
  void tipo2(int i,int k) {
   float angle = 360 / memory_length;
    if (BT_51)   fill(o_colores.getColor(), ALFA); 
    else fill(o_colores.getColor(0), ALFA);
    ellipse((float)(width-x_offset*2)/(LONG-1)*i+x_offset, (float)height/2+default_y+(memory[k][i])*scale_y, memory[0][i]*KNOB_3, memory[0][i]*KNOB_3);
    float eyeDistance = RADIO; 
        
        //float eyeDistance = random(100, 250); 
        float x = cos(radians(i*angle)) * eyeDistance ; 
        float y = sin(radians(i*angle)) * (memory[k][i])*scale_y; 
    stroke(o_colores.getColor(), STROKE_ALFA);
    line(x, (float)height/2+default_y+(memory[k][i])*scale_y, (float)(width-x_offset*2)/(LONG-1)*i+x_offset, (float)height/2-default_y-(memory[k][i])*scale_y);
  }
  void memoria() {
    for (int i = 0;i < LONG; i++) {
      memory[0][i] = o_sound.get_fft(i)*PESO[i]*map(FADER_5, 0, 100, 0, 10);

      if (memory[0][i] < thres) {
        memory[0][i] = 0;
      } 
      else {
        memory[0][i] -= thres;
      }
    }
  }
}